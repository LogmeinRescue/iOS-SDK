//
//  SettingsViewController.m
//  SDKExample
//
//  Created by tkristofcsik on 12/10/15.
//  Copyright © 2015 LogMeIn. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "ViewController.h"

@interface SettingsTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *laserPointerSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *whiteboardSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *hideSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *screenShareMode;
@property (weak, nonatomic) IBOutlet UITextField *channelTextField;

@end


@implementation SettingsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.laserPointerSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kDisableLaserPointerDefaultsKey];
    self.whiteboardSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kDisableWhiteboardDefaultsKey];
    self.hideSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kHideChatFieldDefaultsKey];
    self.screenShareMode.selectedSegmentIndex = [[NSUserDefaults standardUserDefaults] integerForKey:kScreenShareModeDefaultsKey];
    self.channelTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kChannelIdDefaultsKey];
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
    [[NSUserDefaults standardUserDefaults] setInteger:sender.selectedSegmentIndex forKey:kScreenShareModeDefaultsKey];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:kChannelIdDefaultsKey];
}
@end
