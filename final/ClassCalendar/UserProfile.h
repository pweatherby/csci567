//
//  UserProfile.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/15/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KeychainItemWrapper.h"

@interface UserProfile : NSObject

+ (NSString*) GetDeviceID;
+ (NSString*) GetValetKey;
+ (void) SetValetKey:(NSString*) key;

@end
