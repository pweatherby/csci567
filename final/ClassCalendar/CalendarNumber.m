//
//  CalendarNumber.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/14/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarNumber.h"

@implementation CalendarNumber

+ (NSArray*) currentNumbers:(NSString*) termCode
               SessionGroup:(NSString*) sesGrp
                    Subject:(NSString*) subj
{
    NSString* queryStr = @"https://emsdev.csuchico.edu/services/ClassSchedule/CalendarInfo/JSON/NUMBERS_REQUEST.ashx?term=";
    queryStr = [queryStr stringByAppendingString:termCode];
    queryStr = [queryStr stringByAppendingString:@"&session_group="];
    queryStr = [queryStr stringByAppendingString:sesGrp];
    queryStr = [queryStr stringByAppendingString:@"&subject="];
    queryStr = [queryStr stringByAppendingString:subj];
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
                CalendarNumber* item = [[CalendarNumber alloc] initWithJSONAttributes: [parsedJSON objectAtIndex:i]];
                [curItems addObject: item];
            }
            
            return [curItems copy];
        }
    }
    return nil;
}


- (id) initWithJSONAttributes:(NSDictionary*)jsonAttributes
{
    self = [super init];
    if (self)
    {
        _termCode = [jsonAttributes[@"TERM"] stringByDecodingXMLEntities];
        _sessionGroupCode = [jsonAttributes[@"SESSION_GROUP"] stringByDecodingXMLEntities];
        _subjectCode = [jsonAttributes[@"SUBJECT_CODE"] stringByDecodingXMLEntities];
        
        _classNumber = [jsonAttributes[@"CLASS_NUMBER"] stringByDecodingXMLEntities];
        _courseID = [jsonAttributes[@"COURSE_ID"] stringByDecodingXMLEntities];
        _courseOfferNbr = [jsonAttributes[@"COURSE_OFFER_NBR"] stringByDecodingXMLEntities];
        _courseTitleSDesc = [jsonAttributes[@"COURSE_TITLE_SDESC"] stringByDecodingXMLEntities];
        _courseTitleLDesc = [jsonAttributes[@"COURSE_TITLE_LDESC"] stringByDecodingXMLEntities];
        _unitsMin = [jsonAttributes[@"UNITS_MIN"] stringByDecodingXMLEntities];
        _unitsMax = [jsonAttributes[@"UNITS_MAX"] stringByDecodingXMLEntities];
        _unitsRange = _unitsMin;
        if(![_unitsMin isEqualToString:_unitsMax])
        {
            _unitsRange = [[_unitsRange stringByAppendingString:@"-"] stringByAppendingString:_unitsMax];
        }
        _courseDescription = [jsonAttributes[@"COURSE_DESCRIPTION"] stringByDecodingXMLEntities];
    }
    return self;
}

@end
