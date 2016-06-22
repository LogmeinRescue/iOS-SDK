//
//  RescueChatDelegate.h
//  RescueSDK
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RescueChatMessage;

/**
 The <b>RescueChatDelegate</b> protocol defines a set of optional methods you can use to get notified about chat related events. All of the methods in this protocol are optional.
 */
@protocol RescueChatDelegate <NSObject>

@optional

/**
 @brief      Tells the delegate that the technician is typeing.
 */
- (void)rescueChatTyping;

/**
 @brief      Tells the delegate that a new message is received.

 @discussion Messages include chat messages from the technician, the user and the system.

 @param chatMessage The chat message generated.
 */
- (void)rescueChatDidReceiveMessage:(RescueChatMessage *)chatMessage;

/**
 @brief      Tells the delegate that the technician sent a URL.

 @param      url URL sent by the technician.
 */
- (void)rescueChatDidReceiveURL:(NSURL *)url;

@end
