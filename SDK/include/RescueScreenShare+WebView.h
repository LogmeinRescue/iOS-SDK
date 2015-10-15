//
//  RescueScreenShare+WebView.h
//  RescueSDK
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

#import "RescueScreenShare.h"


/**
 The <b>WebView</b> category provides methods and properties to hide password fields in web view objects during screen sharing
 */
@interface RescueScreenShare (WebView)

/**
 @brief      Set of web view objects which password fields should be hidden from the technican.

 @discussion Focused password fields will be hidden in these web views during screen sharing.
             Keyboard will be also hidden when a password field get focus in these web views.
*/
@property (nonatomic, strong) NSMutableSet *webViewsWithPasswordFields;

/**
 @brief      Add or remove web view object from the <b>webViewsWithPasswordFields</b> set.
 
 @param      view The view to add or remove.
 @param      hide <i>YES</i> if you want to add the view to the <b>hiddenViews</b> set, <i>NO</i> to remove.

 @sa         webViewsWithPasswordFields
 */
- (void)setWebViewWithPasswordFields:(UIWebView *)view hidden:(BOOL)hide;

@end
