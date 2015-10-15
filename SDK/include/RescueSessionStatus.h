//
//  RescueSessionStatus.h
//  RescueSDK
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

/**
 Session status during lifecycle
 */
typedef NS_ENUM(NSUInteger, RescueSessionStatus)
{
    /// base state
    RescueSessionStatusIdle,
    /// connecting to the Rescue Service
    RescueSessionStatusConnecting,
    /// connection established with a technician
    RescueSessionStatusConnected,
    /// the technician put the session on hold
    RescueSessionStatusOnHold,
    /// the technician is transering the session to another technician
    RescueSessionStatusTransferred,
    /// disconnecting from the Rescue Service
    RescueSessionStatusDisconnecting,
    /// disconnected from the Rescue Service
    RescueSessionStatusDisconnected,
    /// connected to the Rescue Service, waiting for a technician to pick up the session
    RescueSessionStatusWaitingForTechnician,
    /// internet connection lost between the user and the technician
    RescueSessionStatusConnectionLost
};

/**
 State of the App
 */
typedef NS_ENUM(NSUInteger, RescueAppState)
{
    /// app is running in the background
    RescueAppStateBackground = 1,
    /// app is running in the foreground
    RescueAppStateForeground
};

/**
 Error codes
 */
typedef NS_ENUM(NSUInteger, RescueError)
{
    /// you tried to start the session in pin code mode, but there were no valid pin code
    RescueErrorLoginNoPincode = 1,
    /// your pin code has been expired
    RescueErrorLoginPincodeExpired,
    /// there are no technicians on the channel
    RescueErrorLoginNoTechnicianAvailable,
    /// the technicians on the channel are not configured for mobile support
    RescueErrorLoginNoTechnicianLicense,
    /// there were no answer from the Rescue Service
    RescueErrorLoginNoReply,
    /// unknown reply from the Rescue Service
    RescueErrorLoginUnknownReply,
    /// there were no answer from the Rescue Service in the given time
    RescueErrorLoginTimeout,
};
