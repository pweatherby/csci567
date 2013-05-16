//
//  ShopCartItem.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/16/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "ShopCartItem.h"

@implementation ShopCartItem

- (id) initWithJSONAttributes:(NSDictionary*)jsonAttributes
{
    self = [super init];
    if (self)
    {
        _term = [[CalendarTerm alloc] initWithJSONAttributes:jsonAttributes[@"TERM"]];
        _sessionGroup = [[CalendarSessionGroup alloc] initWithJSONAttributes:jsonAttributes[@"SESSION_GROUP"]];
        _subject = [[CalendarSubject alloc] initWithJSONAttributes:jsonAttributes[@"SUBJECT"]];
        _number = [[CalendarNumber alloc] initWithJSONAttributes:jsonAttributes[@"NUMBER"]];
        _section = [[CalendarSection alloc] initWithJSONAttributes:jsonAttributes[@"SECTION"]];
    }
    return self;
}

@end
