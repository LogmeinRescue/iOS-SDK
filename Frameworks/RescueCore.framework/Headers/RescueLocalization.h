//
//  RescueLocalization.h
//  RescueSDK
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RescueSessionStatus.h"


/**
 Localizable string identifiers
 */
typedef NS_ENUM(NSUInteger, RescueLocalizationStringIdentifier)
{
    /// string for 'connecting' session state
    RescueLocalizationStringIdentifierStatusConnecting,
    /// string for 'waiting for technician' session state
    RescueLocalizationStringIdentifierStatusWaitingForTechnician,
    /// string for 'disconnecting' state
    RescueLocalizationStringIdentifierStatusDisconnecting,
    /// string for 'disconnected' state
    RescueLocalizationStringIdentifierStatusDisconnected,
};


/**
 Rescue SDK provides localization for commonly used strings in many languages. You can access localized string through <b>RescueLocalization</b> class.
 */
@interface RescueLocalization : NSObject

/**
 @brief Localized string for the identifier.

 @param identifier String identifier of the string need to be localized.
 @return The localized string.
 @sa RescueLocalizationStringIdentifier
 */
+ (NSString *)localizedStringFor:(RescueLocalizationStringIdentifier)identifier;

/**
 @brief Get a localized error title.
 @return The localized error title.
 */
+ (NSString *)errorTitle;

/**
 @brief Get the localized error message for the error code.
 @return The localized error message.
 @param error The error code.
 @sa RescueError
 */
+ (NSString *)errorMessageForError:(RescueError)error;

@end
