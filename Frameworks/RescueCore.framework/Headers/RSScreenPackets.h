//
//  RSScreenPackets.h
//  RescueSDK
//
//  Copyright (c) 2003-2016 LogMeIn Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSScreenPackets : NSObject

- (instancetype)initWithWidth:(NSInteger)width withHeight:(NSInteger)height withQuality:(NSUInteger)quality;
- (NSData *)getInfo;
- (NSData *)getInit;
- (NSData *)getDelta;
- (void)pollScreen:(NSMutableData *)bytes;

@end
