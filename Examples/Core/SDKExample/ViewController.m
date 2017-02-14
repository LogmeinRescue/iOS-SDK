//
//  ViewController.m
//  RescueExampleCore
//
//  Copyright (c) 2003-2016 LogMeIn Inc. All rights reserved.
//


#import "ViewController.h"


@interface ViewController ()  <RescueSessionDelegate, RescueLoggerDelegate, RescueChatDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSDateFormatter* dateFormatter;

@property (nonatomic, weak) IBOutlet UILabel* typingLabel;
@property (nonatomic, weak) IBOutlet UITextField* chatTextField;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint* keyboardHeight;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // get permission to show notification for the user about chat messages while in background
    UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];

    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateStyle = NSDateFormatterNoStyle;
    self.dateFormatter.timeStyle = NSDateFormatterShortStyle;
    
    // set API key
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kApiKeyDefaultsKey];
    
    // set channel id
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kChannelIdDefaultsKey];
    
    // set company id and channel name
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kCompanyIdDefaultsKey];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kChannelNameDefaultsKey];

    // set delegate objects of RescueSession
    [RescueSession sharedInstance].delegate = self;
    [RescueChat sharedInstance].delegate = self;
    [[RescueSession sharedInstance] addLogger:self withLevel:RSLogLevelInfo];

    self.typingLabel.hidden = YES;
    self.chatTextField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (IBAction)connectAction:(id)sender
{
    RescueSessionStatus sessionStatus = [RescueSession sharedInstance].sessionStatus;
    
    if (sessionStatus == RescueSessionStatusIdle || sessionStatus == RescueSessionStatusDisconnected)
    {
        // start session
        [self startRescueSession];
    }
    else if (sessionStatus == RescueSessionStatusConnected)
    {
        // close a session
        [[RescueSession sharedInstance] endSession];
    }
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)startRescueSession
{
    [RescueSession sharedInstance].apiKey = [[NSUserDefaults standardUserDefaults] objectForKey:kApiKeyDefaultsKey];

    // clear chat log
    self.textView.text = @"";
    
    // configure session start parameters
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:kSessionStartModeDefaultsKey]) {
        case 0:
        {
            // start session with channel id
            NSString *channelId = [[NSUserDefaults standardUserDefaults] stringForKey:kChannelIdDefaultsKey];
            [[RescueSession sharedInstance].sessionStartParameters startWithChannelId:channelId];
            [[RescueSession sharedInstance] startSession];
        }
            break;
            
        case 1:
        {
            // start session with company id and channel name
            NSString *channelName = [[NSUserDefaults standardUserDefaults] stringForKey:kChannelNameDefaultsKey];
            NSString *companyId = [[NSUserDefaults standardUserDefaults] stringForKey:kCompanyIdDefaultsKey];
            [[RescueSession sharedInstance].sessionStartParameters startWithCompanyId:companyId andChannelName:channelName];
            [[RescueSession sharedInstance] startSession];
        }
            break;
            
        default:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Set Pin Code" message:@"Please enter your pin code." preferredStyle:UIAlertControllerStyleAlert];

            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.keyboardType = UIKeyboardTypeNumberPad;
                textField.placeholder = @"pin code";
            }];

            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSString *pin = alertController.textFields[0].text;
                if (pin) {
                    [[RescueSession sharedInstance].sessionStartParameters startWithPinCode:pin];
                    [[RescueSession sharedInstance] startSession];
                }
            }];
            
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];


        }
            break;
    }
    
}

- (IBAction)tapOutsideChatFieldGesture:(UIGestureRecognizer*)recognizer
{
    [self.chatTextField resignFirstResponder];
}


#pragma mark - RescueSessionDelegate


- (void)rescueSessionError:(RescueError)errorCode withUserInfo:(NSDictionary *)userInfo
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[RescueLocalization errorTitle] message:[RescueLocalization errorMessageForError:errorCode] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)rescueSessionStatusDidChange:(RescueSessionStatus)status
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (status == RescueSessionStatusConnected)
        {
            self.navigationItem.rightBarButtonItem.title = @"Disconnect";
            self.navigationItem.rightBarButtonItem.enabled = YES;
            self.chatTextField.enabled = YES;
            self.typingLabel.text = [NSString stringWithFormat:@"%@ is typing...", [RescueSession sharedInstance].operatorName];
            self.navigationItem.leftBarButtonItem.enabled = NO;
        }
        else if ((status == RescueSessionStatusDisconnected) || (status == RescueSessionStatusIdle))
        {
            self.navigationItem.rightBarButtonItem.title = @"Connect";
            self.navigationItem.rightBarButtonItem.enabled = YES;
            self.chatTextField.enabled = NO;

            self.navigationItem.leftBarButtonItem.enabled = YES;

            [self displaySessionStatistics];
        }
        else
        {
            self.navigationItem.leftBarButtonItem.enabled = NO;
        }
    });
}

#pragma mark - RescueLoggerDelegate

- (void)rescueLogReceived:(RescueLog *)log
{
    NSLog(@"%@", log);
}

#pragma mark - RescueChatDelegate

- (void)rescueChatTyping
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.typingLabel.hidden = NO;
        // remove previous animation
        [self.typingLabel.layer removeAllAnimations];
        
        self.typingLabel.alpha = 1.0;
        
        [UIView animateWithDuration:0.75 delay:0.75 options:0 animations:^{
            self.typingLabel.alpha = 0.0;
        } completion:nil];
    });
}

- (void)rescueChatDidReceiveMessage:(RescueChatMessage *)chatMessage
{
    NSString* speaker = @"";
    
    if (chatMessage.type == RescueChatMessageTypeTechnician)
    {
        speaker = [RescueSession sharedInstance].operatorName;
    }
    else if (chatMessage.type == RescueChatMessageTypeUser)
    {
        speaker = @"You";
    }
    
    [self appendTextToMessagesView:[NSString stringWithFormat:@"\n [%@] %@: %@", [self.dateFormatter stringFromDate:[NSDate date]], speaker, chatMessage.message]];
}


#pragma mark - UITextFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text && ![textField.text isEqualToString:@""])
    {
        [[RescueChat sharedInstance] sendMessage:textField.text];
        textField.text = nil;
        
        return YES;
    }
    else
    {
        return NO;
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [[RescueChat sharedInstance] typing];
    return YES;
}


#pragma mark - Private Methods


- (void)appendTextToMessagesView:(NSString*)textToAppend
{
    // prevent scroll to top after setting .text
    self.textView.scrollEnabled = NO;
    
    self.textView.text = [self.textView.text stringByAppendingString:textToAppend];
    
    self.textView.scrollEnabled = YES;
    [self scrollTextViewToBottom];
}

- (void)scrollTextViewToBottom
{
    CGFloat textHeight = ceilf([self.textView sizeThatFits:CGSizeMake(self.textView.bounds.size.width, FLT_MAX)].height);
    self.textView.contentOffset = CGPointMake(0, MAX(textHeight - self.textView.bounds.size.height, 0));
}

- (void)displaySessionStatistics
{
    // calculate session duration
    NSDate* startDate = [RescueSession sharedInstance].sessionStart ?: [NSDate date]; // can be nil if session isn't started at all
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* components = [calendar components:NSCalendarUnitSecond fromDate:startDate toDate:[NSDate date] options:0];
    
    NSString* durationString = [NSString stringWithFormat:@"%ld second(s)", (long)[components second]];
    
    if ([NSDateComponentsFormatter class]) // nicer string on iOS 8+
    {
        NSDateComponentsFormatter* formatter = [[NSDateComponentsFormatter alloc] init];
        formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;
        durationString = [formatter stringFromDateComponents:components];
    }
    
    // calculate session data usage
    size_t transmittedBytes = [RescueSession sharedInstance].transmittedData;
    NSString* transmittedDataString = [NSString stringWithFormat:@"%zud byte(s)", transmittedBytes];
    
    if ([NSByteCountFormatter class]) // nicer string on iOS 8+
    {
        transmittedDataString = [NSByteCountFormatter stringFromByteCount:transmittedBytes countStyle:NSByteCountFormatterCountStyleFile];
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self appendTextToMessagesView:[NSString stringWithFormat:@"\n-----\n Session duration: %@", durationString]];
        [self appendTextToMessagesView:[NSString stringWithFormat:@"\n Transmitted data: %@", transmittedDataString]];
    });
}

// The callback for frame-changing of keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboardFrame = [kbFrame CGRectValue];
    CGFloat height = keyboardFrame.size.height;

    self.keyboardHeight.constant = 8+height;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.keyboardHeight.constant = 8;
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}


#pragma mark - segue


- (IBAction)unwindFromSettings:(UIStoryboardSegue *)segue
{

}

@end
