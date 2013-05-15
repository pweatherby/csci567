//
//  CalendarSection.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/14/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkActivityTracker.h"
#import "StringUtility.h"

@interface CalendarSection : NSObject

+ (NSArray*) currentSections:(NSString*) termCode
                SessionGroup:(NSString*) sesGrp
                       CrsID:(NSString*) crsID
                      CrsOfr:(NSString*) crsOffer;

@property (nonatomic, readonly) NSString* termCode;
@property (nonatomic, readonly) NSString* sessionGroupCode;
@property (nonatomic, readonly) NSString* courseID;
@property (nonatomic, readonly) NSString* courseOfferNbr;


@property (nonatomic, readonly) NSString* classSection;
@property (nonatomic, readonly) NSString* classStatus;
@property (nonatomic, readonly) NSString* classStatusLDesc;


@property (nonatomic, readonly) NSString* classType;
@property (nonatomic, readonly) NSString* classTypeLDesc;
@property (nonatomic, readonly) NSString* registrationNbr;

@property (nonatomic, readonly) NSString* component;
@property (nonatomic, readonly) NSString* componentLDesc;
@property (nonatomic, readonly) NSString* associatedClass;

@property (nonatomic, readonly) NSString* enrlStatus;
@property (nonatomic, readonly) NSString* enrlStatusLDesc;
@property (nonatomic, readonly) NSString* enrlTotal;
@property (nonatomic, readonly) NSString* enrlCapacity;
@property (nonatomic, readonly) NSString* enrlAutoWaitlist;

@property (nonatomic, readonly) NSString* waitDaemon;
@property (nonatomic, readonly) NSString* waitTotal;
@property (nonatomic, readonly) NSString* waitCapacity;


- (id)initWithJSONAttributes:(NSDictionary*)jsonAttributes;

@end
