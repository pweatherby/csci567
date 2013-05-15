//
//  CalendarMeetingPattern.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/14/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringUtility.h"
#import "CalendarInstructor.h"

@interface CalendarMeetingPattern : NSObject

@property (nonatomic, readonly) NSString* classMtgNbr;

@property (nonatomic, readonly) NSString* building;
@property (nonatomic, readonly) NSString* room;

@property (nonatomic, readonly) NSString* startDate;
@property (nonatomic, readonly) NSString* endDate;

@property (nonatomic, readonly) NSString* startDateLDesc;
@property (nonatomic, readonly) NSString* endDateLDesc;

@property (nonatomic, readonly) NSString* startTime;
@property (nonatomic, readonly) NSString* endTime;

@property (nonatomic, readonly) NSString* days;
@property (nonatomic, readonly) NSArray* instructors;

- (id)initWithJSONAttributes:(NSDictionary*)jsonAttributes;

@end
