//
//  CalendarListTableViewController.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/2/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarMeetingPatternsTableViewController.h"

@interface CalendarListTableViewController : UITableViewController
@property (nonatomic, strong) NSArray*  calendarData;
@property (nonatomic, strong) id dataParam;
@end
