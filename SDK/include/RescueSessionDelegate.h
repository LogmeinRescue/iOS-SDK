//
//  RescueSessionDelegate.h
//  RescueSDK
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RescueSessionStatus.h"


/**
 The <b>RescueSessionDelegate</b> protocol defines a set of methods you can use to get notified about session related events.
 */
@protocol RescueSessionDelegate <NSObject>

@required

/**
 @brief      Tells the delegate that an error occured during session.

 @param      errorCode The error code.
 @param      userInfo  More info about the error. In case of <i>RescueErrorNoTechnicianAvailable</i>, the dictionary contains the URL set in the administration center if there are no technicians on the channel.
 
 @sa         RescueError
 */
- (void)rescueSessionError:(RescueError)errorCode withUserInfo:(NSDictionary *)userInfo;

@optional

/**
 @brief      Tells the delegate that the state of the session has changed.

 @param      status The new session state.

 @discussion This method is optional.
 */
- (void)rescueSessionStatusDidChange:(RescueSessionStatus)status;

@end

