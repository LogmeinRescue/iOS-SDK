//
//  RescueCameraDelegate.h
//  RescueSDK
//
//  Copyright (c) 2003-2016 LogMeIn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 The <b>RescueCameraDelegate</b> protocol defines a set of optional methods you can use to get notified about camera streaming related events.
 All of the methods in this protocol are optional.
 */
@protocol RescueCameraDelegate <NSObject>

@optional

/**
 @brief      Tells the delegate that the display streaming has been started.
 */
- (void)rescueCameraStreamingStarted;

/**
 @brief      Tells the delegate that the flashlight has been turned on.
 */
- (void)rescueCameraFlashTurnedOn;

/**
 @brief      Tells the delegate that the flashlight has been turned off.
 */
- (void)rescueCameraFlashTurnedOff;

@end