//
//  MoviesTableViewController.m
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "MoviesTableViewController.h"

@interface MoviesTableViewController ()

@end

@implementation MoviesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentTopItems = [ITunesFetcher topMovies];
}

@end
