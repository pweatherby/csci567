//
//  CalendarTerm.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 4/25/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarTerm.h"

@implementation CalendarTerm


+ (NSArray*) currentTerms
{
    /// DEBUG; RETURNING TEST VALUES
    /// return [ScheduleTerm testValues];
    NSURL* url = [[NSURL alloc] initWithString:@"https://emsdev.csuchico.edu/services/ClassSchedule/CalendarInfo/JSON/TERMS_REQUEST.ashx"];
    
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
            NSMutableArray* curTerms = [[NSMutableArray alloc] init];
            
            for(int i = 0; i < parsedJSON.count; i++)
            {
                CalendarTerm* item = [[CalendarTerm alloc] initWithJSONAttributes: [parsedJSON objectAtIndex:i]];
                [curTerms addObject: item];
            }
            
            return [curTerms copy];
        }
    }
    return nil;
}

+ (NSArray*) testValues
{
    
    NSMutableArray* curTerms = [[NSMutableArray alloc] init];
    CalendarTerm* F13 = [[CalendarTerm alloc] initWithCode:@"2138"
                                                     SDesc:@"Fa 2013"
                                                     LDesc:@"Fall 2013"];
    [curTerms addObject: F13];
    CalendarTerm* S14 = [[CalendarTerm alloc] initWithCode:@"2142"
                                                     SDesc:@"Spr 2014"
                                                     LDesc:@"Spring 2014"];
    [curTerms addObject: S14];
    CalendarTerm* F14 = [[CalendarTerm alloc] initWithCode:@"2148"
                                                     SDesc:@"Fa 2014"
                                                     LDesc:@"Fall 2014"];
    [curTerms addObject: F14];
    return [curTerms copy];
}


- (id) initWithJSONAttributes:(NSDictionary*)jsonAttributes
{
    self = [super init];
    if (self)
    {
        _code = [jsonAttributes[@"TERM"] stringByDecodingXMLEntities];
        _shortDesc = [jsonAttributes[@"TERM_SDESC"] stringByDecodingXMLEntities];
        _longDesc = [jsonAttributes[@"TERM_LDESC"] stringByDecodingXMLEntities];
        _abbrev = [[_shortDesc stringByReplacingOccurrencesOfString:@" 20" withString:@""] uppercaseString];
    }
    return self;
}


- (id) initWithCode:(NSString*)c
              SDesc:(NSString*)s
              LDesc:(NSString*)l
{
    self = [super init];
    if (self)
    {
        _code = c;
        _shortDesc = s;
        _longDesc = l;
        _abbrev = [[_shortDesc stringByReplacingOccurrencesOfString:@" 20" withString:@""] uppercaseString];
    }
    return self;
}

@end
