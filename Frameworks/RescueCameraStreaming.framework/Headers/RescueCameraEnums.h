//
//  RescueCameraEnums.h
//  RescueSDK
//
//  Copyright (c) 2003-2016 LogMeIn Inc. All rights reserved.
//

/**
 @brief      Physical camera on the device device.
 */
typedef NS_ENUM(NSUInteger, RescueCameraDevice)
{
    /// camera on the back side of the device
    RescueCameraDeviceBack,
    /// camera on the front side of the device
    RescueCameraDeviceFront,
};

/**
 @brief      Flashlight state.
 */
typedef NS_ENUM(NSUInteger, RescueCameraFlash)
{
    /// flashlight is unavailable
    RescueCameraFlashUnavailable,
    /// flashlight is off
    RescueCameraFlashOff,
    /// flashlight is on
    RescueCameraFlashOn,
};