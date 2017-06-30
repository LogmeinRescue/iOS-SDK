//
//  ViewController.h
//  RescueExampleDisplay
//
//  Copyright (c) 2003-2016 LogMeIn Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RescueCore/RescueCore-Swift.h>


static NSString* const kDisableLaserPointerDefaultsKey = @"RSSDKDisableLaserPointerDefaultsKey";
static NSString* const kDisableWhiteboardDefaultsKey = @"RSSDKDisableWhiteBoardDefaultsKey";
static NSString* const kHideChatFieldDefaultsKey = @"RSSDKHideChatFieldDefaultsKey";
static NSString* const kScreenShareModeDefaultsKey = @"RSSDKScreenShareModeDefaultsKey";
static NSString* const kSessionStartModeDefaultsKey = @"RSSDKSessionStartModeDefaultsKey";
static NSString* const kChannelIdDefaultsKey = @"RSSDKChannelIdDefaultsKey";
static NSString* const kChannelNameDefaultsKey = @"RSSDKChannelNameDefaultsKey";
static NSString* const kCompanyIdDefaultsKey = @"RSSDKCompanyIdDefaultsKey";
static NSString* const kApiKeyDefaultsKey = @"RSSDKApiKeyDefaultsKey";


@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextView* textView;

@end
