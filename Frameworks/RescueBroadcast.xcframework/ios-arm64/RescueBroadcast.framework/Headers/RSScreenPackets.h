//
//  RSScreenPackets.h
//  RescueSDK
//
//  Copyright © 2020 LogMeIn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSScreenPackets : NSObject

- (instancetype)initWithWidth:(NSInteger)width withHeight:(NSInteger)height withQuality:(NSUInteger)quality;
- (NSData *)getInfo;
- (NSData *)getInit;
- (NSData *)getDelta;
- (void)pollScreen:(NSMutableData *)bytes;

@end
