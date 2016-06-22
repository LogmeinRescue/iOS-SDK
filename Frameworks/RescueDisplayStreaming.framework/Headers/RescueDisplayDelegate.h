//
//  RescueDisplayDelegate.h
//  RescueSDK
//
//  Copyright (c) 2003-2016 LogMeIn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 The <b>RescueDisplayDelegate</b> protocol defines a set of optional methods you can use to get notified about display streaming related events.
 All of the methods in this protocol are optional.
 */
@protocol RescueDisplayDelegate <NSObject>

@optional

/**
 @brief      Ask the delegate for a view object to use as root view for display streaming.

 @discussion This method is called if <b>RescueDisplay</b>'s <b>mode</b> is set to <i>RescueDisplayModeRootView</i> but no root view was provided.

 @return     A view object from the view hierarchy to use as root view for display streaming.
 */
- (UIView *)rescueDisplayRequestViewToSendToTechnician;

/**
 @brief      Tells the delegate that the display streaming has been started.
 */
- (void)rescueDisplayStreamingDidStart;

/**
 @brief      Tells the delegate that the display streaming has been stopped.
 */
- (void)rescueDisplayStreamingDidStop;

@end

