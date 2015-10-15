//
//  RescueLogLevel.h
//  RescueSDK
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

#pragma once

#ifdef __OBJC__

/**
 Log levels
 */
typedef NS_ENUM(NSUInteger, RSLogLevel){
    /// The system is in distress, customers are probably being affected.
    RSLogLevelError     = 0,
    /// An unexpected technical or business event happened, customers may be affected.
    RSLogLevelWarning   = 10,
    /// Things we want to see at high volume in case we need to forensically analyze an issue.
    RSLogLevelInfo      = 20,
    /// Just about everything that doesn't make the "Info" level.
    RSLogLevelDebug     = 30,
    /// Extremely detailed and potentially high volume logs that you don't typically want enabled even during normal development.
    RSLogLevelTrace     = 40};

#else

typedef enum RSLogLevel
{
    RSLogLevelError     = 0,
    RSLogLevelWarning   = 10,
    RSLogLevelInfo      = 20,
    RSLogLevelDebug     = 30,
    RSLogLevelTrace     = 40
} RSLogLevel;

#endif