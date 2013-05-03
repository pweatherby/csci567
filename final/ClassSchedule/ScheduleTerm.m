//
//  ScheduleTerm.m
//  ClassSchedule
//
//  Created by Paul Weatherby on 4/25/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "ScheduleTerm.h"

@implementation ScheduleTerm


+ (NSArray*) currentTerms
{
    /// DEBUG; RETURNING TEST VALUES
    return [ScheduleTerm testValues];
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
            NSMutableArray* curTerms = [[NSMutableArray alloc] init];
            
            for(int i = 0; i < parsedJSON.count; i++)
            {
                ScheduleTerm* item = [[ScheduleTerm alloc] initWithJSONAttributes: [parsedJSON objectAtIndex:i]];
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
    ScheduleTerm* F13 = [[ScheduleTerm alloc] initWithCode:@"2138"
                                                     SDesc:@"Fa 2013"
                                                     LDesc:@"Fall 2013"];
    [curTerms addObject: F13];
    ScheduleTerm* S14 = [[ScheduleTerm alloc] initWithCode:@"2142"
                                                     SDesc:@"Spr 2014"
                                                     LDesc:@"Spring 2014"];
    [curTerms addObject: S14];
    ScheduleTerm* F14 = [[ScheduleTerm alloc] initWithCode:@"2148"
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
        _code = jsonAttributes[@"TERM"];
        _shortDesc = jsonAttributes[@"TERM_SDESC"];
        _longDesc = jsonAttributes[@"TERM_LDESC"];
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
