//
//  RescueLog.h
//  RescueSDK
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

#import "RescueLogLevel.h"


/**
 @brief      A log object comes from Rescue SDK.
 */
@interface RescueLog : NSObject

/**
 @brief      The log message itself.
 */
@property (readonly, nonatomic) NSString* message;

/**
 @brief      The category of the log. Means which part of the SDK sends it.
 */
@property (readonly, nonatomic) NSString* category;

/**
 @brief      The level of the log.

 @sa         RSLogLevel
 */
@property (readonly, nonatomic) RSLogLevel level;

/**
 @brief      The date-time when the log was sent to the logger facility.
 */
@property (readonly, nonatomic) NSDate* timestamp;

/**
 @brief      Returns an initialized <b>RescueLog</b> object with all its properties set.

 @param      message   The log message itself.
 @param      category  The category of the log.
 @param      level     The level of the log.
 @param      timestamp The date-time when the log was

 @return     An initilaized <b>RescueLog</b> object with all its properties set.
 */
- (instancetype)initWithMessage:(NSString*)message
                       category:(NSString*)category
                          level:(RSLogLevel)level
                      timestamp:(NSDate*)timestamp;

@end
