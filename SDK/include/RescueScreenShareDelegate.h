//
//  RescueScreenShareDelegate.h
//  RescueSDK
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 The <b>RescueScreenShareDelegate</b> protocol defines a set of optional methods you can use to get notified about screen sharing related events.
 All of the methods in this protocol are optional.
 */
@protocol RescueScreenShareDelegate <NSObject>

@optional

/**
 @brief      Ask the delegate for a view object to use as root view for screen sharing.

 @discussion This method is called if <b>RescueScreenShare</b>'s <b>mode</b> is set to <i>RescueScreenShareModeRootView</i> but no root view was provided.

 @return     A view object from the view hierarchy to use as root view for screen sharing.
 */
- (UIView *)rescueScreenShareRequestViewToSendToTechnician;

/**
 @brief      Tells the delegate that the screen sharing has been started.
 */
- (void)rescueScreenShareDidStart;

/**
 @brief      Tells the delegate that the screen sharing has been ended.
 */
- (void)rescueScreenShareDidStop;

@end

