//
//  RescueSession.h
//  RescueSDK
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RescueSingleton.h"
#import "RescueSessionStatus.h"
#import "RescueSessionStartParameters.h"
#import "RescueSessionDelegate.h"
#import "RescueLoggerDelegate.h"


/**
 The connection between your application and the Rescue Technician Console is represented by a <b>RescueSession</b> object. This is a singleton object you access it by calling the <b>sharedInstance</b> class method.
 */
@interface RescueSession : RescueSingleton

/** @name Identification */

/**
 @brief      Unique identifier for the app.
 
 @discussion Every app need an API key, without it starting a Rescue session will always fail.
 */
@property (nonatomic, strong) NSString *apiKey;

/** @name Delegate */

/**
 @brief      The object that acts as the delegate of <b>RescueSession</b>.

 @sa         RescueSessionDelegate
 */
@property (nonatomic, weak) id<RescueSessionDelegate> delegate;


/** @name Control the session life cycle */

/**
 @brief      Start a Rescue session using the configuration from the <b>sessionStartParameters</b> object.

 @discussion The <b>startSession</b> method is asynchronous, it will return immediately.
             You will be notified via the <b>delegate</b> about the outcome of the session start.

 @sa         RescueSessionStartParameters
 @sa         RescueSessionDelegate
 @sa         delegate
 */
- (void)startSession;

/**
 @brief      End the Rescue session.

 @discussion The <b>endSession</b> method is asynchronous, it will return immediately.
             You will be notified via the <b>delegate</b> about the outcome of the session start.

 @sa         RescueSessionDelegate
 @sa         delegate
 */
- (void)endSession;

/**
 @brief      Clean up the Rescue SDK, delete every data stored by it.
 */
- (void)reset;


/** @name Logging */

/**
 @brief      Subscribe to get log messages from Rescue SDK.

 @discussion Async call, see delegate methods in RescueLoggerDelegate to get feedback about the successfulness of subscription.

 @param       loggerDelegate The object who will receive log messages.
 @param       level          The receiver will get messages on this or above this level. See RSLogLevel in RescueLoggerDelegate.h.
 */
- (void)addLogger:(id<RescueLoggerDelegate>)loggerDelegate withLevel:(RSLogLevel)level;

/**
 @brief      Unsubscribe from Rescue SDK to get log messages.

 @param      loggerDelegate The object who is subscribed to log messages.
 */
- (void)removeLogger:(id<RescueLoggerDelegate>)loggerDelegate;


/** @name Configure session start */

/**
 @brief      This property stores the session start configuration.

 @discussion Automatically created, call its methods to configure it.

 @sa         RescueSessionStartParameters
 */
@property (nonatomic, strong, readonly) RescueSessionStartParameters *sessionStartParameters;


/** @name Information about the the session */

/**
 @brief      State of the session.

 @discussion This property is KVO compliant.

 @sa         RescueSessionStatus
 */
@property (nonatomic, readonly) RescueSessionStatus sessionStatus;

/**
 @brief      Name of the technician.

 @discussion This property is KVO compliant
 */
@property (nonatomic, readonly) NSString *operatorName;


/** @name Methods to get information after the session ended */

/**
 @brief      Date-time of the start of the session.
 */
@property (nonatomic, readonly) NSDate *sessionStart;

/**
 @brief      Transmitted data during session
 */
@property (nonatomic, readonly) size_t transmittedData;


/**
 @brief      URL of the customer survey.

 @return     The URL of the customer survey.

 @discussion The URL can change during a support session, so only use this method at support session end
 */
- (NSURL *)afterSessionSurveyURL;




@end
