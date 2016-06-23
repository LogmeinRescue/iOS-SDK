//
//  RescueSessionStatus.h
//  RescueSDK
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


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
 Error codes
 */
typedef NS_ENUM(NSUInteger, RescueError)
{
    /// missing pin code
    RescueErrorNoPincode = 1,
    /// the pin code has been expired
    RescueErrorPincodeExpired,
    /// there are no technicians on the channel
    RescueErrorNoTechnicianAvailable,
    /// the technicians on the channel are not configured for mobile support
    RescueErrorNoTechnicianLicense,
    /// there were no answer from the Rescue Service
    RescueErrorNoReply,
    /// unknown reply from the Rescue Service
    RescueErrorUnknownReply,
    /// there were no answer from the Rescue Service in the given time
    RescueErrorTimeout,
    
    /// no API key was set for the session
    RescueErrorApiKeyMissing,
    /// the Rescue SDK could not access or send the bundle identifier
    RescueErrorAppIdMissing ,
    /// the given API key does not exist in the Rescue Service
    RescueErrorApiKeyDoesNotExist,
    /// the given API key is disabled in the Rescue Service
    RescueErrorApiKeyDisabled ,
    /// the given API key is not valid with the app's bundle identifier
    RescueErrorApiKeyAndAppIdNotFromTheSameCompany,
    /// the given pin code was not belong to the company with the given API key
    RescueErrorPrivateCodeApiKeyNotFromTheSameCompany,
    /// the given channel does not beong to the company with the given API key
    RescueErrorChannelApiKeyNotFromTheSameCompany,
    /// the given channel does not exists
    RescueErrorChannelDoesNotExist,
    /// the given company does not exists
    RescueErrorCompanyDoesNotExist,
    /// the Rescue service could not parse the request
    RescueErrorRequest,
    /// a required parameter is missing (e.g. channel id in a channel session)
    RescueErrorRequiredParameterMissing,
    /// the pin code is invalid
    RescueErrorInvalidPincode,
    /// the pin code was not generated for this type of session
    RescueErrorInvalidPincodeForSessionType,
};
