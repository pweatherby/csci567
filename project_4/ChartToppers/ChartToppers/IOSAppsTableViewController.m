//
//  IOSAppsTableViewController.m
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "IOSAppsTableViewController.h"

@interface IOSAppsTableViewController ()

@end

@implementation IOSAppsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentTopItems = [ITunesFetcher topFreeApps];
}

@end
