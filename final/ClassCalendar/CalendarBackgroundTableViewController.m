//
//  CalendarBackgroundTableViewController.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/15/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarBackgroundTableViewController.h"

@implementation CalendarBackgroundTableViewController

- (UINavigationItem *)navigationItem{
    UINavigationItem *item = [super navigationItem];
    if (item != nil && item.backBarButtonItem == nil)
    {
        item.backBarButtonItem = [[UIBarButtonItem alloc] init];
        item.backBarButtonItem.title = [self title];
    }
    
    return item;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor* bkg = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"body-bkg-pixel.jpg"]];
    // initWithHue:22.34f saturation:97.86f brightness:54.9f alpha:1.0f];
    // initWithRed:(140.0/256) green:(54.0/256) blue:(3.0/256) alpha:1.0f];
    self.tableView.backgroundColor = bkg;
    
    UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"body-bkg.png"]];
    view.contentMode = UIViewContentModeTop;
    self.tableView.backgroundView = view;
}

@end
