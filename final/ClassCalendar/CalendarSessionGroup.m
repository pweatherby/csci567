//
//  CalendarSessionGroup.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/2/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarSessionGroup.h"

@implementation CalendarSessionGroup


+ (NSArray*) currentSessionGroups:(NSString*) termCode
{
    /// DEBUG; RETURNING TEST VALUES
    /// return [CalendarSessionGroup testValues];
    NSString* queryStr = @"https://emsdev.csuchico.edu/services/ClassSchedule/CalendarInfo/JSON/SESSIONS_REQUEST.ashx?term=";
    queryStr = [queryStr stringByAppendingString:termCode];
    NSURL* url = [[NSURL alloc] initWithString:queryStr];
    
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
                CalendarSessionGroup* item = [[CalendarSessionGroup alloc] initWithJSONAttributes: [parsedJSON objectAtIndex:i]];
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
    CalendarSessionGroup* StateGroup = [[CalendarSessionGroup alloc] initWithTerm:@"2138"
                                                                           sesGrp:@"10"
                                                                            abbvr:@"State"
                                                                            LDesc:@"State Supported Classes"];
    [curItems addObject: StateGroup];
    CalendarSessionGroup* SelfGroup = [[CalendarSessionGroup alloc] initWithTerm:@"2138"
                                                                          sesGrp:@"20"
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
        _termCode = [jsonAttributes[@"TERM"] stringByDecodingXMLEntities];
        _sessionGroupCode = [jsonAttributes[@"SESSION_GROUP"] stringByDecodingXMLEntities];
        _abbrev = [jsonAttributes[@"GROUP_ABBREV"] stringByDecodingXMLEntities];
        _longDesc = [jsonAttributes[@"GROUP_LDESC"] stringByDecodingXMLEntities];
    }
    return self;
}


- (id) initWithTerm:(NSString*)t
             sesGrp:(NSString*)c
              abbvr:(NSString*)a
              LDesc:(NSString*)l
{
    self = [super init];
    if (self)
    {
        _termCode = t;
        _sessionGroupCode = c;
        _longDesc = l;
        _abbrev = a;
    }
    return self;
}


@end
