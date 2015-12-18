//
//  ViewController.m
//  SDKExample
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

#import "ViewController.h"

#warning TODO: Set your own channel id
// your channel ID
static NSString* const kChannelId = nil;


@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextView* textView;
@property (nonatomic, strong) NSDateFormatter* dateFormatter;

@property (nonatomic, weak) IBOutlet UILabel* typingLabel;
@property (nonatomic, weak) IBOutlet UITextField* chatTextField;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint* keyboardHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // get permission to show notification for the user about chat messages while in background
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)
    {
        UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    }
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateStyle = NSDateFormatterNoStyle;
    self.dateFormatter.timeStyle = NSDateFormatterShortStyle;
    

    #warning TODO: Set your own API key
    // set API key
    [RescueSession sharedInstance].apiKey = @"";
    
    // set delegate objects of RescueSession
    [RescueSession sharedInstance].delegate = self;
    [RescueChat sharedInstance].delegate = self;
    [[RescueSession sharedInstance] addLogger:self withLevel:RSLogLevelInfo];

    self.typingLabel.hidden = YES;
    self.chatTextField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (IBAction)connectAction:(id)sender {
    // ask for channel ID if it's not set in code.
    // *** IT'S JUST FOR DEBUG PURPOSES, IN PRODUCTION SET IT IN SOURCE CODE. ***
    NSString* channelID = kChannelId ?: [[NSUserDefaults standardUserDefaults] stringForKey:kChannelIdDefaultsKey];
    if (!channelID) {
        [self askForChannelId];
        return;
    }
    
    RescueSessionStatus sessionStatus = [RescueSession sharedInstance].sessionStatus;
    
    if (sessionStatus == RescueSessionStatusIdle || sessionStatus == RescueSessionStatusDisconnected)
    {
        self.textView.text = @"";
        
        [RescueScreenShare sharedInstance].disableLaserPointer = [[NSUserDefaults standardUserDefaults] boolForKey:kDisableLaserPointerDefaultsKey];
        [RescueScreenShare sharedInstance].disableWhiteboard = [[NSUserDefaults standardUserDefaults] boolForKey:kDisableWhiteboardDefaultsKey];
        
        [[RescueScreenShare sharedInstance] setView:self.chatTextField hidden:[[NSUserDefaults standardUserDefaults] boolForKey:kHideChatFieldDefaultsKey]];
        
        switch ([[NSUserDefaults standardUserDefaults] integerForKey:kScreenShareModeDefaultsKey]) {
            case RescueScreenShareModeAppScreen:
                [RescueScreenShare sharedInstance].mode = RescueScreenShareModeAppScreen;
                break;
                
            case RescueScreenShareModeRootView:
                [RescueScreenShare sharedInstance].mode = RescueScreenShareModeRootView;
                [RescueScreenShare sharedInstance].rootView = self.textView;
                break;

            default:
                [RescueScreenShare sharedInstance].mode = RescueScreenShareModeDisabled;
                break;
        }
        
        // start a session
        [[RescueSession sharedInstance].sessionStartParameters startWithChannelId:channelID];
        [[RescueSession sharedInstance] startSession];
    }
    else if (sessionStatus == RescueSessionStatusConnected)
    {
        // close a session
        [[RescueSession sharedInstance] endSession];
    }
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (IBAction)tapOutsideChatFieldGesture:(UIGestureRecognizer*)recognizer {
    [self.chatTextField resignFirstResponder];
}

#pragma mark - RescueSessionDelegate

- (void)rescueSessionError:(RescueError)errorCode withUserInfo:(NSDictionary *)userInfo {
    [[[UIAlertView alloc] initWithTitle:[RescueLocalization errorTitle] message:[RescueLocalization errorMessageForError:errorCode] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)rescueSessionStatusDidChange:(RescueSessionStatus)status {
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

- (void)rescueLogReceived:(RescueLog *)log {
    NSLog(@"%@", log);
}

#pragma mark - RescueChatDelegate

- (void)rescueChatTyping {
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

- (void)rescueChatDidReceiveMessage:(RescueChatMessage *)chatMessage {
    NSString* speaker = @"";
    
    if (chatMessage.type == RescueChatMessageTypeTechnician)
    {
        speaker = [RescueSession sharedInstance].operatorName;
    }
    else if (chatMessage.type == RescueChatMessageTypeUser)
    {
        speaker = @"You";
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self appendTextToMessagesView:[NSString stringWithFormat:@"\n [%@] %@: %@", [self.dateFormatter stringFromDate:[NSDate date]], speaker, chatMessage.message]];
    });
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text && ![textField.text isEqualToString:@""]) {
        [[RescueChat sharedInstance] sendMessage:textField.text];
        textField.text = nil;
        
        return YES;
    }
    else {
        return NO;
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [[RescueChat sharedInstance] typing];
    return YES;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString* enteredText = [alertView textFieldAtIndex:0].text;
    
    if (enteredText && ![enteredText isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setObject:enteredText forKey:kChannelIdDefaultsKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self connectAction:nil];
    }
}

#pragma mark - Private Methods

- (void)askForChannelId {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Set Channel ID" message:@"Please enter your channel ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alert show];
}

- (void)appendTextToMessagesView:(NSString*)textToAppend {
    // prevent scroll to top after setting .text
    self.textView.scrollEnabled = NO;
    
    self.textView.text = [self.textView.text stringByAppendingString:textToAppend];
    
    self.textView.scrollEnabled = YES;
    [self scrollTextViewToBottom];
}

- (void)scrollTextViewToBottom {
    CGFloat textHeight = ceilf([self.textView sizeThatFits:CGSizeMake(self.textView.bounds.size.width, FLT_MAX)].height);
    self.textView.contentOffset = CGPointMake(0, MAX(textHeight - self.textView.bounds.size.height, 0));
}

- (void)displaySessionStatistics {
    // calculate session duration
    NSDate* startDate = [RescueSession sharedInstance].sessionStart ?: [NSDate date]; // can be nil if session isn't started at all
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
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
- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboardFrame = [kbFrame CGRectValue];
    CGFloat height = keyboardFrame.size.height;

    if ([[[UIDevice currentDevice] systemVersion] floatValue] <= 8.0f)
    {
        if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
        {
            height = keyboardFrame.size.width;
        }
    }

    self.keyboardHeight.constant = 8+height;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.keyboardHeight.constant = 8;
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}


#pragma mark - segue

- (IBAction)cancelSettings:(UIStoryboardSegue *)segue
{

}

@end
