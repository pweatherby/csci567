//
//  CalendarInstructor.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/14/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarInstructor.h"

@implementation CalendarInstructor

- (id) initWithJSONAttributes:(NSDictionary*)jsonAttributes
{
    self = [super init];
    if (self)
    {
        _instAssignSeq = [jsonAttributes[@"INSTR_ASSING_SEQ"] stringByDecodingXMLEntities];
        
        _displayName = [jsonAttributes[@"NAME_DISPLAY"] stringByDecodingXMLEntities];
        _lastName = [jsonAttributes[@"LAST_NAME"] stringByDecodingXMLEntities];
        _firstName = [jsonAttributes[@"FIRST_NAME"] stringByDecodingXMLEntities];
        
    }
    return self;
}

@end
