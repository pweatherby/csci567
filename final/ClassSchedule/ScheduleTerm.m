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

- (id) initWithJSONAttributes:(NSDictionary*)jsonAttributes
{
    self = [super init];
    if (self)
    {
        _code = jsonAttributes[@"TERM"];
        _abbrev = jsonAttributes[@"TERM_ABBREV"];
        _longDesc = jsonAttributes[@"TERM_LDESC"];
        _regBeginDt = jsonAttributes[@"REG_BEGIN_DT"];
        _regEndDt = jsonAttributes[@"REG_END_DT"];
    }
    return self;
}

@end
