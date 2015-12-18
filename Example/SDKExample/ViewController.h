//
//  ViewController.h
//  SDKExample
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RescueSDK.h"

static NSString* const kDisableLaserPointerDefaultsKey = @"RSSDKDisableLaserPointerDefaultsKey";
static NSString* const kDisableWhiteboardDefaultsKey = @"RSSDKDisableWhiteBoardDefaultsKey";
static NSString* const kHideChatFieldDefaultsKey = @"RSSDKHideChatFieldDefaultsKey";
static NSString* const kScreenShareModeDefaultsKey = @"RSSDKScreenShareModeDefaultsKey";
static NSString* const kChannelIdDefaultsKey = @"RSSDKChannelIdDefaultsKey";

@interface ViewController : UIViewController <RescueSessionDelegate, RescueLoggerDelegate, RescueChatDelegate, UITextFieldDelegate, UIAlertViewDelegate>


@end

