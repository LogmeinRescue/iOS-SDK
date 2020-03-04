//
//  RSMediaLibManager.h
//  RescueSDK
//
//  Copyright © 2020 LogMeIn Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreVideo/CoreVideo.h>

#import "RescueMediaDelegate.h"


/**
 @brief      Media streaming functionality.
 */
@interface RSMediaLibManager: NSObject

/**
 @brief      UIView to render the local stream into.

 @discussion This is the designated initializer.
 */
- (nonnull instancetype)initWithAudio:(BOOL)audioEnabled;

/**
 @brief      UIView to render the local stream into.
 */
@property (nonatomic, weak, nullable) UIView *cameraRenderView;

/**
 @brief      Camera to use for streaming.
 */
@property (nonatomic) RSCameraDevice camera;

- (void)initMediaSession;

/**
 @brief      Start to render the local stream to the given UIView.
 
 @sa         cameraRenderView
 */
- (void)startLocalStreamRendering;

/**
 @brief      Stop rendering the local stream.
 */
- (void)stopLocalStreamRendering;

/**
 @brief      Create stream for local audio and/or video. An existing stream will be stopped if NO specified.
 */
- (void)switchLocalStreamSendingOfAudio:(BOOL)sendAudio video:(BOOL)sendVideo;

/**
 @brief      Mutes/unmutes the mic used for recording audio stream.
 */
- (void)muteRecording:(BOOL)mute;

/**
 @brief      Reset the inner states of the media session.
 */
- (void)resetMediaSession;

/**
 @brief      Destroy and recreate the media session.
 */
- (void)restartMediaSession;

@property (nonatomic, weak, nullable) id<RescueMediaDelegate> mediaDelegate;

- (void)mediaMessage:(nonnull NSString *)message;
- (void)dataChannelMessage:(nonnull NSData *)message;

@property (nonatomic, strong, nullable) CALayer *renderLayer;

@property (nonatomic) CGSize streamResolution;

- (void)onFrame:(nonnull CVImageBufferRef)buffer;
- (void)sendStoredMessages;

@end

