//
//  ScheduleTerm.h
//  ClassSchedule
//
//  Created by Paul Weatherby on 4/25/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkActivityTracker.h"
@interface ScheduleTerm : NSObject

+ (NSArray*) currentTerms;

@property (nonatomic, readonly) NSString* code;
@property (nonatomic, readonly) NSString* abbrev;
@property (nonatomic, readonly) NSString* longDesc;
@property (nonatomic, readonly) NSString* regBeginDt;
@property (nonatomic, readonly) NSString* regEndDt;

- (id)initWithJSONAttributes:(NSDictionary*)jsonAttributes;

@end
