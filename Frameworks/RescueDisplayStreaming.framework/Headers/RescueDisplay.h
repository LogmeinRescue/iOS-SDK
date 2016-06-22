//
//  RescueDisplay.h
//  RescueSDK
//
//  Copyright (c) 2003-2016 LogMeIn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <RescueCore/RescueCore.h>

#import "RescueDisplayDelegate.h"


/**
 Display streaming modes.
 */
typedef NS_ENUM(NSUInteger, RescueDisplayMode)
{
    /// Stream the whole app screen.
    RescueDisplayModeAppScreen,
    /// Stream the selected view (and its subviews). Known bug: in this mode the laser pointer and whiteboard won't show in technician console. Please disable laserpointer and whiteboard (with (disableLaserPointer and disableWhiteboard methods)) if you plan to use this mode.
    RescueDisplayModeRootView,
    /// Display streaming disabled.
    RescueDisplayModeDisabled,
};


/**
 The <b>RescueDisplay</b> class provides methods and properties to manage display streaming functionality of the Rescue SDK.
 */
@interface RescueDisplay : RescueSingleton

/**
 @brief      The object that acts as the delegate of <b>RescueDisplay</b>.

 @sa         RescueDisplayDelegate
 */
@property (nonatomic, weak) id<RescueDisplayDelegate> delegate;

/**
 @brief      Display streaming mode.

 @discussion The value of this property configures which part of the app's screen will be streamed to the technician.
             Default value is <i>RescueDisplayModeAppScreen</i>, so the entire screen of the app will be streamed.
             If you want to disable display streaming set this property to <i>RescueDisplayModeDisabled</i>.

 @sa         RescueDisplayMode
 */
@property (nonatomic) RescueDisplayMode mode;

/**
 @brief      View to stream to the technician if *mode* set to <i>RescueDisplayModeRootView</i>.

 @discussion The view will only be streamed if it is visible. The view's subviews will also be streamed.
             If the property is not set when display streaming is initiated by the technician,
             the SDK will call the delegates <b>rescueDisplayRequestViewToSendToTechnician</b> method to get a view to stream.
             If there is still no view after this, the whole app screen will be streamed.

 @sa         RescueDisplayMode
 */
@property (nonatomic, weak) UIView *rootView;

/**
 @brief      Set of UIViews to hide during display streaming.

 @discussion During capturing the display which will be streamed to the technican, the views in the set will be blacked out.
 */
@property (nonatomic, strong) NSMutableSet *hiddenViews;

/**
 @brief      Add or remove view object from the <b>hiddenViews</b> set.

 @param      view The view object to add or remove.
 @param      hide <i>YES</i> if you want to add the view object to the <b>hiddenViews</b> set, <i>NO</i> to remove.

 @sa         hiddenViews
 */
- (void)setView:(UIView *)view hidden:(BOOL)hide;


/**
 @brief      A Boolean value that determines whether the technican can use the laser pointer feature in the technician console.

 @discussion If the value of this property is <i>NO</i> (the default), the technician can use the laser pointer feature in the tech console during display streaming. Set to <i>YES</i> if you want to disable the feature.
 */
@property (nonatomic) BOOL disableLaserPointer;

/**
 @brief      A Boolean value that determines whether the technican can use the whiteboard feature in the technician console.

 @discussion If the value of this property is <i>NO</i> (the default), the technician can use the whiteboard feature in the tech console during display streaming. Set to <i>YES</i> if you want to disable the feature.
 */
@property (nonatomic) BOOL disableWhiteboard;


- (void)enable;

@end
