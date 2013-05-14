//
//  CalendarNumber.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/14/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkActivityTracker.h"
#import "StringUtility.h"

@interface CalendarNumber : NSObject

+ (NSArray*) currentNumbers:(NSString*) termCode
               SessionGroup:(NSString*) sesGrp
                    Subject:(NSString*) subj;

@property (nonatomic, readonly) NSString* termCode;
@property (nonatomic, readonly) NSString* sessionGroupCode;
@property (nonatomic, readonly) NSString* subjectCode;

@property (nonatomic, readonly) NSString* classNumber;
@property (nonatomic, readonly) NSString* courseID;
@property (nonatomic, readonly) NSString* courseOfferNbr;
@property (nonatomic, readonly) NSString* courseTitleSDesc;
@property (nonatomic, readonly) NSString* courseTitleLDesc;
@property (nonatomic, readonly) NSString* unitsMin;
@property (nonatomic, readonly) NSString* unitsMax;
@property (nonatomic, readonly) NSString* unitsRange;
@property (nonatomic, readonly) NSString* courseDescription;

- (id)initWithJSONAttributes:(NSDictionary*)jsonAttributes;

@end
