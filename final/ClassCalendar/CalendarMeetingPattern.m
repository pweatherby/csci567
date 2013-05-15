//
//  CalendarMeetingPattern.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/14/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarMeetingPattern.h"

@implementation CalendarMeetingPattern

- (id) initWithJSONAttributes:(NSDictionary*)jsonAttributes
{
    self = [super init];
    if (self)
    {        
        _classMtgNbr = [jsonAttributes[@"CLASS_MTG_NBR"] stringByDecodingXMLEntities];
        
        _building = [jsonAttributes[@"BUILDING"] stringByDecodingXMLEntities];
        _room = [jsonAttributes[@"ROOM"] stringByDecodingXMLEntities];
        
        _startDate = [jsonAttributes[@"MEETING_DATE_START"] stringByDecodingXMLEntities];
        _endDate = [jsonAttributes[@"MEETING_DATE_END"] stringByDecodingXMLEntities];
        
        _startDateLDesc = [jsonAttributes[@"MEETING_DATE_START_LDESC"] stringByDecodingXMLEntities];
        _endDateLDesc = [jsonAttributes[@"MEETING_DATE_END_LDESC"] stringByDecodingXMLEntities];
        
        _startTime = [jsonAttributes[@"MEETING_TIME_START"] stringByDecodingXMLEntities];
        _endTime = [jsonAttributes[@"MEETING_TIME_END"] stringByDecodingXMLEntities];
        
        _days = [jsonAttributes[@"STND_MTG_PAT"] stringByDecodingXMLEntities];
        
        NSMutableArray* curItems = [[NSMutableArray alloc] init];
        
        NSArray* insts = jsonAttributes[@"INSTRUCTORS"];
        if(insts)
        {
            for(int i = 0; i < insts.count; i++)
            {
                CalendarInstructor* item = [[CalendarInstructor alloc] initWithJSONAttributes: [insts objectAtIndex:i]];
                [curItems addObject: item];
            }
            
            _instructors = [curItems copy];
        }
    }
    return self;
}

@end
