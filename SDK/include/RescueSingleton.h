//
//  RescueSingleton.h
//  RescueSDK
//
//  Copyright (c) 2003-2015 LogMeIn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Root class for Rescue SDK singleton classes
 */
@interface RescueSingleton : NSObject

/**
 @brief      Returns the one and only instance from the class.

 @return     The initialized singleton object.
 */
+ (instancetype)sharedInstance;

@end
