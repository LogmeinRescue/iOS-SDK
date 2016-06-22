//
//  RescueCamera.h
//  RescueSDK
//
//  Copyright (c) 2003-2016 LogMeIn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <RescueCore/RescueCore.h>

#import "RescueCameraDelegate.h"
#import "RescueCameraEnums.h"


/**
 The <b>RescueCamera</b> class provides methods and properties to manage camera streaming functionality of the Rescue SDK.
 */
@interface RescueCamera : RescueSingleton

/**
 @brief      The object that acts as the delegate of <b>RescueCamera</b>.
 
 @sa         RescueCameraDelegate
 */
@property (nonatomic, weak) id<RescueCameraDelegate> delegate;

/**
 @brief      The physical camera to use for streaming
 
 @discussion The value of this property configures which camera of the device should be used for streaming.
 
 @sa         RescueCameraDevice
 */
@property (nonatomic) RescueCameraDevice camera;


/**
 @brief      Start render the camera stream localy for the user.

 @param      view   This view will be used to render the camera stream.
 */
- (void)startLocalStreamRenderingInView:(UIView *)view;

/**
 @brief      Stop render the camera stream localy for the user in the <b>renderView</b>.
 
 @discussion The last rendered frame will be visible in the render view after stopping the local rendering.
 */
- (void)stopLocalStreamRendering;


/**
 @brief      Pause the streaming.
 
 @discussion This will pause sending the camera stream to the technician and also pause rendering the stream localy for the user.

 @sa         resumeStreaming
 @sa         isPaused
*/
- (void)pauseStreaming;

/**
 @brief      Resume the streaming.
 
 @discussion This will resume sending the camera stream to the technician and also resume rendering the stream localy for the user.

 @sa         pauseStreaming
 @sa         isPaused
 */
- (void)resumeStreaming;

/**
 @brief      Turn on flashlight on the device.

 @sa         hasFlash
 @sa         flashState
 */
- (void)turnOnFlash;

/**
 @brief      Turn off flashlight on the device.
 
 @sa         hasFlash
 @sa         flashState
 */
- (void)turnOffFlash;

/**
 @brief      A Boolean value indicating whether the sending of the camera stream started to the technician. (read-only)
 */
@property (nonatomic, readonly) BOOL isStreaming;

/**
 @brief      A Boolean value indicating whether the sending and rendering of the camera stream has been paused by the user. (read-only)
 */
@property (nonatomic, readonly) BOOL isPaused;

/**
 @brief      A Boolean value indicating whether the sending and rendering of the camera stream has been frozen by the technician. (read-only)
 */
@property (nonatomic, readonly) BOOL isFrozen;

/**
 @brief      A Boolean value indicating whether the device has flashlight.
 */
@property (nonatomic, readonly) BOOL hasFlash;

/**
 @brief      Status of the flaslight.
 
 @sa         RescueCameraFlash
 */
@property (nonatomic, readonly) RescueCameraFlash flashState;

@end
