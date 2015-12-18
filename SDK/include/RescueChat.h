//
//  RescueChat.h
//  RescueSDK
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RescueSingleton.h"
#import "RescueChatDelegate.h"


/**
 The <b>RescueChat</b> class provides methods and properties to manage chat functionality in the Rescue SDK.
 */
@interface RescueChat : RescueSingleton

/**
 @brief      The object that acts as the delegate of <b>RescueChat</b>.

 @sa         RescueChatDelegate
 */
@property (nonatomic, weak) id<RescueChatDelegate> delegate;

/**
 @brief      Array of chat messages sent, generated or received during the current session.

 @discussion Chat messages are in timeline. The array contains only RescueChatMessage objects.
 */
@property (nonatomic, weak, readonly) NSArray* messages;

/**
 @brief      Send chat message to the technician.

 @param      message The string to send.
 */
- (void)sendMessage:(NSString *)message;

/**
 @brief      Notify the SDK that the user is typeing a message for the technician.

 @discussion You can send this message for every time the user makes an input, the SDK will optimize the frequency to forward the message to the technician
 */
- (void)typing;

@end
