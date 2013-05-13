//
//  CalendarSessionGroup.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/2/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkActivityTracker.h"
@interface CalendarSessionGroup : NSObject

+ (NSArray*) currentSessionGroups:(NSString*) termCode;

@property (nonatomic, readonly) NSString* code;
@property (nonatomic, readonly) NSString* abbrev;
@property (nonatomic, readonly) NSString* longDesc;
@property (nonatomic, readonly) int displaySeq;

- (id)initWithJSONAttributes:(NSDictionary*)jsonAttributes;

@end
