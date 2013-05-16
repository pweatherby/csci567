//
//  CalendarProfileTableViewController.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/15/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarProfileTableViewController.h"

@interface CalendarProfileTableViewController ()

@end

@implementation CalendarProfileTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString* dID = [UserProfile GetDeviceID];
    self.dIDLabel.text = dID;
    self.vKeyLabel.text = [UserProfile GetValetKey];
}

@end
