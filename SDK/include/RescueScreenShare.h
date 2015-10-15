//
//  RescueScreenShare.h
//  RescueSDK
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

#import "RescueScreenShareDelegate.h"


/**
 Screen sharing modes.
 */
typedef NS_ENUM(NSInteger, RescueScreenShareMode)
{
    /// Share the whole app screen.
    RescueScreenShareModeAppScreen,
    /// Share the selected view (and its subviews). Known bug: in this mode the laser pointer and whiteboard won't show in technician console. Please disable laserpointer and whiteboard (with (disableLaserPointer and disableWhiteboard methods)) if you plan to use this mode.
    RescueScreenShareModeRootView,
    /// Screen sharing disabled.
    RescueScreenShareModeDisabled,
};


/**
 The <b>RescueScreenShare</b> class provides methods and properties to manage screen sharing functionality in the Rescue SDK.
 */
@interface RescueScreenShare : RescueSingleton

/**
 @brief      The object that acts as the delegate of <b>RescueScreenShare</b>.

 @sa         RescueScreenShareDelegate
 */
@property (nonatomic, weak) id<RescueScreenShareDelegate> delegate;

/**
 @brief      Screen sharing mode.

 @discussion The value of this property configures which part of the app's screen will be shared with the technician. 
             Default value is <i>RescueScreenShareModeAppScreen</i>, so the entire screen of the app will be shared. 
             If you want to disable screen sharing set this property to <i>RescueScreenShareModeDisabled</i>.

 @sa         RescueScreenShareMode
 */
@property (nonatomic) RescueScreenShareMode mode;

/**
 @brief      View to share with the technician if *mode* set to <i>RescueScreenShareModeRootView</i>.

 @discussion The view will only be shared if the view is visible. The view's subviews will also be shared.
             If the property is not set when screen sharing is initiated by the technician,
             the SDK will call the delegates <b>rescueScreenShareRequestViewToSendToTechnician</b> method to get a view to share.
             If there is still no view after this, the whole app screen will be shared.

 @sa         RescueScreenShareMode
 */
@property (nonatomic, weak) UIView *rootView;

/**
 @brief      Set of UIViews to hide during screen share.

 @discussion During rendering the images which will be shared with the technican, the views in the set will be blacked out.
 */
@property (nonatomic, strong) NSMutableSet *hiddenViews;

/**
 @brief      Add or remove view object from the <b>hiddenViews</b> set.

 @param      view The view tobject o add or remove.
 @param      hide <i>YES</i> if you want to add the view object to the <b>hiddenViews</b> set, <i>NO</i> to remove.

 @sa         hiddenViews
 */
- (void)setView:(UIView *)view hidden:(BOOL)hide;


/**
 @brief      A Boolean value that determines whether the technican can use the laser pointer feature in the technician console.

 @discussion If the value of this property is <i>NO</i> (the default), the technician can use the laser pointer feature in the tech console during screen sharing. Set to <i>YES</i> if you want to disable the feature.
 */
@property (nonatomic) BOOL disableLaserPointer;

/**
 @brief      A Boolean value that determines whether the technican can use the whiteboard feature in the technician console.

 @discussion If the value of this property is <i>NO</i> (the default), the technician can use the whiteboard feature in the tech console during screen sharing. Set to <i>YES</i> if you want to disable the feature.
 */
@property (nonatomic) BOOL disableWhiteboard;


@end
