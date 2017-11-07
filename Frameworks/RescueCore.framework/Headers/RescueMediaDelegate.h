//
//  RSMediaLibManagerDelegate.h
//  RescueSDK
//
//  Created by tkristofcsik on 28/04/16.
//  Copyright © 2016 tkristofcsik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

/**
 @brief      Physical camera on the device device.
 */
typedef NS_ENUM(NSUInteger, RSCameraDevice)
{
    /// camera on the back side of the device
    RSCameraDeviceBack,
    /// camera on the front side of the device
    RSCameraDeviceFront,
};


@protocol RescueMediaDelegate <NSObject>

/**
 @brief      A Boolean value that determines whether the technican requested the audio stream feature.
 
 @discussion If the value of this property is <i>NO</i> (the default), the technician did no requested the audio feature in the tech console during camera streaming.
 */
@property (nonatomic) BOOL audioRequested;

@property (nonatomic) BOOL paused;
@property (nonatomic) BOOL muted;
@property (nonatomic, readonly) BOOL frozen;
@property (nonatomic) BOOL streamingStarted;

- (void)updateTrafficSent:(size_t)sent andReceived:(size_t)received;
- (void)addBlurToView:(UIView * _Nonnull)view;
- (void)sendingStarted;
- (void)sendMediaMessage:(NSString * _Nonnull)mediaMessage;
- (void)processData:(NSData * _Nonnull)data;
- (void)globalTransformation:(CGAffineTransform) transformation;
- (void)turnFlashlightOff;
- (void)streamSizeDidChange;

@end
