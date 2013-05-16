//
//  UserProfile.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/15/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile

+ (NSString*) GetDeviceID
{
    return @"";
}

+ (NSString*) GetValetKey
{
    return @"";
}

+ (void) SetValetKey:(NSString*) key
{
    KeychainItemWrapper* wrapper = [[KeychainItemWrapper alloc] init];
    [wrapper setObject:key forKey:@"noble.coder.pweatherby.classCalendar.valetKey"];
}

@end
