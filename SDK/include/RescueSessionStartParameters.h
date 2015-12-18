//
//  RescueSessionStartParameters.h
//  RescueSDK
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 The <b>RescueSessionStartParameters</b> class is used by the <b>RescueSession</b> class to configure the session start parameters. Do not create your own instance of this class, <b>RescueSession</b> will hold its own, use that one.
 */
@interface RescueSessionStartParameters : NSObject


/** @name Start modes */

/**
 @brief      Configure the session start parameters to create a session with the given company id and channel name.

 @param      companyId   Company identifier in the Rescue System.
 @param      channelName Channel name in the Rescue System.
 */
- (void)startWithCompanyId:(NSString *)companyId andChannelName:(NSString *)channelName;

/**
 @brief      Configure the session start parameters to create a session with the given channel id.

 @param     channelId Channel identifier in the Rescue System.
 */
- (void)startWithChannelId:(NSString *)channelId;

/**
 @brief      Configure the session start parameters to try to continue the last unfinished session.

 @return    <i>YES</i> if there is an unfinished session, session start parameters is configured to continue this session or <i>NO</i> if there is no session to continue, session won't start with this configuration.
 */
- (BOOL)continueSession;

/**
 @brief      Returns a boolean indicating weather the instance holds a valid configuration to start a session.

 @return     <i>YES</i> if configuration is valid to start a session, otherwise <i>NO</i>

 @discussion Returning <i>YES</i> this method does not guarantee, that the session will start, or the given parameters are valid. It just checks for the existence of the parameters.
 */
- (BOOL)isConfigured;


/** @name Additional parameters */

/**
 @brief      Pass this name along with session start, technician consol will display this name for the user in 'Name' field
 */
@property (strong, nonatomic) NSString *name;

/**
 @brief      Pass this comment along with session start, technician consol will display this comment in 'Custom Field 1' field
 */
@property (strong, nonatomic) NSString *comment1;

/**
 @brief      Pass this comment along with session start, technician consol will display this comment in 'Custom Field 2' field
 */
@property (strong, nonatomic) NSString *comment2;

/**
 @brief      Pass this comment along with session start, technician consol will display this comment in 'Custom Field 3' field
 */
@property (strong, nonatomic) NSString *comment3;

/**
 @brief      Pass this comment along with session start, technician consol will display this comment in 'Custom Field 4' field
 */
@property (strong, nonatomic) NSString *comment4;

/**
 @brief      Pass this comment along with session start, technician consol will display this comment in 'Custom Field 5' field
 */
@property (strong, nonatomic) NSString *comment5;

@end
