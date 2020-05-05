//
//  SettingsViewController.m
//  RescueExampleDisplay
//
//  Copyright (c) 2003-2016 LogMeIn Inc. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "ViewController.h"

@interface SettingsTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *laserPointerSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *whiteboardSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *hideSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *screenShareMode;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sessionStartMode;
@property (weak, nonatomic) IBOutlet UITextField *channelIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *channelNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *apiKeyTextField;
@property (weak, nonatomic) IBOutlet UILabel *appIDLabel;

@property (weak, nonatomic) IBOutlet UITextField *parameterName;
@property (weak, nonatomic) IBOutlet UITextField *parameter1;
@property (weak, nonatomic) IBOutlet UITextField *parameter2;
@property (weak, nonatomic) IBOutlet UITextField *parameter3;
@property (weak, nonatomic) IBOutlet UITextField *parameter4;
@property (weak, nonatomic) IBOutlet UITextField *parameter5;

@end


@implementation SettingsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.laserPointerSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kDisableLaserPointerDefaultsKey];
    self.whiteboardSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kDisableWhiteboardDefaultsKey];
    self.hideSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kHideChatFieldDefaultsKey];
    self.screenShareMode.selectedSegmentIndex = [[NSUserDefaults standardUserDefaults] integerForKey:kScreenShareModeDefaultsKey];
    self.sessionStartMode.selectedSegmentIndex = [[NSUserDefaults standardUserDefaults] integerForKey:kSessionStartModeDefaultsKey];
    self.channelIdTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kChannelIdDefaultsKey];
    self.channelNameTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kChannelNameDefaultsKey];
    self.companyIdTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kCompanyIdDefaultsKey];
    self.apiKeyTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kApiKeyDefaultsKey];
    self.appIDLabel.text = [NSBundle mainBundle].bundleIdentifier;
    self.parameterName.text = [[NSUserDefaults standardUserDefaults] objectForKey:kParameterNameDefaultsKey];
    self.parameter1.text = [[NSUserDefaults standardUserDefaults] objectForKey:kParameter1DefaultsKey];
    self.parameter2.text = [[NSUserDefaults standardUserDefaults] objectForKey:kParameter2DefaultsKey];
    self.parameter3.text = [[NSUserDefaults standardUserDefaults] objectForKey:kParameter3DefaultsKey];
    self.parameter4.text = [[NSUserDefaults standardUserDefaults] objectForKey:kParameter4DefaultsKey];
    self.parameter5.text = [[NSUserDefaults standardUserDefaults] objectForKey:kParameter5DefaultsKey];
}

- (IBAction)switchChanged:(UISwitch *)sender
{
    if (sender == self.laserPointerSwitch)
    {
        [[NSUserDefaults standardUserDefaults] setBool:self.laserPointerSwitch.isOn forKey:kDisableLaserPointerDefaultsKey];
    }
    else if (sender == self.whiteboardSwitch)
    {
        [[NSUserDefaults standardUserDefaults] setBool:self.whiteboardSwitch.isOn forKey:kDisableWhiteboardDefaultsKey];
    }
    else if (sender == self.hideSwitch)
    {
        [[NSUserDefaults standardUserDefaults] setBool:self.hideSwitch.isOn forKey:kHideChatFieldDefaultsKey];
    }
}

- (IBAction)segmentedChanged:(UISegmentedControl *)sender
{
    if (sender == self.screenShareMode)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:sender.selectedSegmentIndex forKey:kScreenShareModeDefaultsKey];
    }
    else if (sender == self.sessionStartMode)
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
    else if (textField == self.parameterName)
    {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:kParameterNameDefaultsKey];
    }
    else if (textField == self.parameter1)
    {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:kParameter1DefaultsKey];
    }
    else if (textField == self.parameter2)
    {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:kParameter2DefaultsKey];
    }
    else if (textField == self.parameter3)
    {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:kParameter3DefaultsKey];
    }
    else if (textField == self.parameter4)
    {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:kParameter4DefaultsKey];
    }
    else if (textField == self.parameter5)
    {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:kParameter5DefaultsKey];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
