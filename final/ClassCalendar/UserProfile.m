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
    return [UserProfile GetNewDeviceID];
    NSString* dID = @"";
    NSError* error = [[NSError alloc] init];
    dID = [SFHFKeychainUtils getPasswordForUsername:@"noble.coder.pweatherby.classCalendar.deviceID"
                                     andServiceName:@"noble.coder.pweatherby.classCalendar.deviceID"
                                              error:&error];
    //KeychainItemWrapper* wrapper = [[KeychainItemWrapper alloc] init];
    //dID = [wrapper objectForKey:];
    if(!dID || [dID isEqualToString:@""])
    {
        dID = [UserProfile GetNewDeviceID];
    }
    
    
    // Debug Stuff
    if(!dID || [dID isEqualToString:@""])
    {
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd-hh-mm-sss-mm-hh-dd-MM-yyyy"];
        dID = [DateFormatter stringFromDate:[NSDate date]];
    }
    // END Debug Stuff
    return dID;
}

+ (NSString*) GetNewDeviceID
{
    NSString* dID = @"";
    NSError* error = [[NSError alloc] init];
    //NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    //[DateFormatter setDateFormat:@"yyyy-MM-dd-hh-mm-ss"];
    // dID = [DateFormatter stringFromDate:[NSDate date]];
    dID = [dID stringByAppendingString:[UserProfile uuid]];
    [SFHFKeychainUtils storeUsername:@"noble.coder.pweatherby.classCalendar.deviceID"
                         andPassword:dID
                      forServiceName:@"noble.coder.pweatherby.classCalendar.deviceID"
                      updateExisting:TRUE
                               error:&error];
    
    
    // Debug Stuff
    if(!dID || [dID isEqualToString:@""])
    {
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd-hh-mm-sss-mm-hh-dd-MM-yyyy"];
        dID = [DateFormatter stringFromDate:[NSDate date]];
    }
    // END Debug Stuff
    return dID;
}

+ (NSString*) GetValetKey
{
    NSError* error = [[NSError alloc] init];
    NSString* vKey = @"";
    vKey = [SFHFKeychainUtils getPasswordForUsername:@"noble.coder.pweatherby.classCalendar.valetKey"
                                      andServiceName:@"noble.coder.pweatherby.classCalendar.valetKey"
                                               error:&error];
    // KeychainItemWrapper* wrapper = [[KeychainItemWrapper alloc] init];
    // vKey = [wrapper objectForKey:@"noble.coder.pweatherby.classCalendar.valetKey"];
    if(vKey)
    {
        vKey = @"";
    }
    return vKey;
}

+ (void) SetValetKey:(NSString*) key
{
    NSError* error = [[NSError alloc] init];
    [SFHFKeychainUtils storeUsername:@"noble.coder.pweatherby.classCalendar.valetKey"
                         andPassword:key
                      forServiceName:@"noble.coder.pweatherby.classCalendar.valetKey"
                      updateExisting:TRUE
                               error:&error];
    //KeychainItemWrapper* wrapper = [[KeychainItemWrapper alloc] init];
    //[wrapper setObject:key forKey:@"noble.coder.pweatherby.classCalendar.valetKey"];
}

// retrieved from http://stackoverflow.com/questions/7016311/how-to-generate-unique-identifier
+ (NSString *)uuid
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge NSString *)uuidStringRef;
}

@end
