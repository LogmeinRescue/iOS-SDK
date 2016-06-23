//
//  SettingsViewController.m
//  RescueExampleCore
//
//  Copyright (c) 2003-2016 LogMeIn Inc. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "ViewController.h"

@interface SettingsTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *sessionStartMode;
@property (weak, nonatomic) IBOutlet UITextField *channelIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *channelNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *apiKeyTextField;
@property (weak, nonatomic) IBOutlet UILabel *appIDLabel;

@end


@implementation SettingsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sessionStartMode.selectedSegmentIndex = [[NSUserDefaults standardUserDefaults] integerForKey:kSessionStartModeDefaultsKey];
    self.channelIdTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kChannelIdDefaultsKey];
    self.channelNameTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kChannelNameDefaultsKey];
    self.companyIdTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kCompanyIdDefaultsKey];
    self.apiKeyTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kApiKeyDefaultsKey];
    self.appIDLabel.text = [NSBundle mainBundle].bundleIdentifier;
}

- (IBAction)segmentedChanged:(UISegmentedControl *)sender
{
    if (sender == self.sessionStartMode)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:sender.selectedSegmentIndex forKey:kSessionStartModeDefaultsKey];
    }
}

#pragma mark - UITextFieldDelegate


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.channelIdTextField )
    {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:kChannelIdDefaultsKey];
    }
    else if (textField == self.channelNameTextField)
    {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:kChannelNameDefaultsKey];
    }
    else if (textField == self.companyIdTextField)
    {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:kCompanyIdDefaultsKey];
    }
    else if (textField == self.apiKeyTextField)
    {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:kApiKeyDefaultsKey];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
