//
//  CalendarSectionsTableViewController.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/14/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarListTableViewController.h"

#import "CalendarNumber.h"
#import "CalendarSection.h"
#import "CalendarSectionTableViewCell.h"

@interface CalendarSectionsTableViewController : CalendarListTableViewController

@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UITextView* descrLabel;

@end
