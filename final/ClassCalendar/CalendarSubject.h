//
//  CalendarSubject.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/13/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkActivityTracker.h"
#import "StringUtility.h"

@interface CalendarSubject : NSObject

+ (NSArray*) currentSubjects:(NSString*) termCode
                SessionGroup:(NSString*) sesGrp;

@property (nonatomic, readonly) NSString* termCode;
@property (nonatomic, readonly) NSString* sessionGroupCode;
@property (nonatomic, readonly) NSString* subjectCode;
@property (nonatomic, readonly) NSString* shortDesc;
@property (nonatomic, readonly) NSString* longDesc;
@property (nonatomic, readonly) NSString* formalDesc;

- (id)initWithJSONAttributes:(NSDictionary*)jsonAttributes;

@end
