//
//  ShopCartItem.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/16/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarTerm.h"
#import "CalendarSessionGroup.h"
#import "CalendarSubject.h"
#import "CalendarNumber.h"
#import "CalendarSection.h"

@interface ShopCartItem : NSObject


@property (nonatomic, readonly) CalendarTerm* term;
@property (nonatomic, readonly) CalendarSessionGroup* sessionGroup;
@property (nonatomic, readonly) CalendarSubject* subject;
@property (nonatomic, readonly) CalendarNumber* number;
@property (nonatomic, readonly) CalendarSection* section;

- (id)initWithJSONAttributes:(NSDictionary*)jsonAttributes;

@end
