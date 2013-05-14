//
//  CalendarSessionGroup.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/2/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkActivityTracker.h"
#import "StringUtility.h"

@interface CalendarSessionGroup : NSObject

+ (NSArray*) currentSessionGroups:(NSString*) termCode;

@property (nonatomic, readonly) NSString* termCode;
@property (nonatomic, readonly) NSString* sessionGroupCode;
@property (nonatomic, readonly) NSString* abbrev;
@property (nonatomic, readonly) NSString* longDesc;
@property (nonatomic, readonly) int displaySeq;

- (id)initWithJSONAttributes:(NSDictionary*)jsonAttributes;

@end
