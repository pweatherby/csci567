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
        NSArray* items = jsonAttributes[@"TERM"];
        if(items && items.count > 0)
        {
            _term = [[CalendarTerm alloc] initWithJSONAttributes:[items objectAtIndex:0]];
        }
        items = jsonAttributes[@"SESSION_GROUP"];
        if(items && items.count > 0)
        {
            _sessionGroup = [[CalendarSessionGroup alloc] initWithJSONAttributes:[items objectAtIndex:0]];
        }
        items = jsonAttributes[@"SUBJECT"];
        if(items && items.count > 0)
        {
            _subject = [[CalendarSubject alloc] initWithJSONAttributes:[items objectAtIndex:0]];
        }
        items = jsonAttributes[@"NUMBER"];
        if(items && items.count > 0)
        {
            _number = [[CalendarNumber alloc] initWithJSONAttributes:[items objectAtIndex:0]];
        }
        items = jsonAttributes[@"CLASS_SECTION"];
        if(items && items.count > 0)
        {
            _section = [[CalendarSection alloc] initWithJSONAttributes:[items objectAtIndex:0]];
        }
    }
    return self;
}

@end
