//
//  ScheduleSessionGroup.m
//  ClassSchedule
//
//  Created by iOS Student on 5/2/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "ScheduleSessionGroup.h"

@implementation ScheduleSessionGroup


+ (NSArray*) currentSessionGroups:(NSString*) termCode
{
    /// DEBUG; RETURNING TEST VALUES
    return [ScheduleSessionGroup testValues];
    NSURL* url = [[NSURL alloc] initWithString:@""];
    
    [[NetworkActivityTracker sharedInstance] showActivityIndicator];
    NSData* rawContents = [[NSData alloc] initWithContentsOfURL:url];
    [[NetworkActivityTracker sharedInstance] hideActivityIndicator];
    if(rawContents)
    {
        NSError* error;
        NSArray* parsedJSON = [NSJSONSerialization JSONObjectWithData:rawContents
                                                              options:0
                                                                error:&error];
        if (error)
        {
            NSLog(@"JSON Parsing Error: %@", error);
        }
        
        if(parsedJSON)
        {
            NSMutableArray* curItems = [[NSMutableArray alloc] init];
            
            for(int i = 0; i < parsedJSON.count; i++)
            {
                ScheduleSessionGroup* item = [[ScheduleSessionGroup alloc] initWithJSONAttributes: [parsedJSON objectAtIndex:i]];
                [curItems addObject: item];
            }
            
            return [curItems copy];
        }
    }
    return nil;
}

+ (NSArray*) testValues
{
    
    NSMutableArray* curItems = [[NSMutableArray alloc] init];
    ScheduleSessionGroup* StateGroup = [[ScheduleSessionGroup alloc] initWithCode:@"10"
                                                                            abbvr:@"State"
                                                                            LDesc:@"State Supported Classes"];
    [curItems addObject: StateGroup];
    ScheduleSessionGroup* SelfGroup = [[ScheduleSessionGroup alloc] initWithCode:@"20"
                                                                           abbvr:@"Self"
                                                                           LDesc:@"Self Supported Classes"];
    [curItems addObject: SelfGroup];
    return [curItems copy];
}


- (id) initWithJSONAttributes:(NSDictionary*)jsonAttributes
{
    self = [super init];
    if (self)
    {
        _code = jsonAttributes[@"SESSION_GROUP"];
        _abbrev = jsonAttributes[@"GROUP_ABBREV"];
        _longDesc = jsonAttributes[@"GROUP_LDESC"];
    }
    return self;
}


- (id) initWithCode:(NSString*)c
              abbvr:(NSString*)a
              LDesc:(NSString*)l
{
    self = [super init];
    if (self)
    {
        _code = c;
        _longDesc = l;
        _abbrev = a;
    }
    return self;
}


@end
