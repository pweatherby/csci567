//
//  CalendarInstructor.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/14/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringUtility.h"

@interface CalendarInstructor : NSObject

@property (nonatomic, readonly) NSString* instAssignSeq;

@property (nonatomic, readonly) NSString* displayName;
@property (nonatomic, readonly) NSString* lastName;
@property (nonatomic, readonly) NSString* firstName;

- (id)initWithJSONAttributes:(NSDictionary*)jsonAttributes;

@end
