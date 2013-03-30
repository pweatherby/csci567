//
//  ITunesUTableViewController.m
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "ITunesUTableViewController.h"

@interface ITunesUTableViewController ()

@end

@implementation ITunesUTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentTopItems = [ITunesFetcher topITunesUCourses];
}

@end
