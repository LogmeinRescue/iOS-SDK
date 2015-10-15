//
//  RescueLoggerDelegate.h
//  RescueSDK
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

#import "RescueLog.h"


/**
 The <b>RescueLoggerDelegate</b> protocol defines a set of methods you can use to get notified about Rescue SDK log messages.
 */
@protocol RescueLoggerDelegate <NSObject>

/**
 @brief      Tells the delegate that there is a new log message is available.

 @discussion Called on a background thread. Required.

 @param      log The object which contains metadata and the log message.
 */
- (void)rescueLogReceived:(RescueLog*)log;

@optional

/**
 @brief      Tells the delegate that subscription was succesful for log messages.

 @discussion Called on a background thread. Optional.
 */
- (void)rescueLoggerAddingWasSuccesful;

/**
 @brief      Tells the delegate that subscription was unsuccesful for log messages.

 @discussion Called on a background thread. Optional.

 @param error The error object which provides additional information.
 */
- (void)rescueLoggerAddingFailed:(NSError*)error;

@end

