//
//  TVEpisodesTableViewController.m
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "TVEpisodesTableViewController.h"

@interface TVEpisodesTableViewController ()

@end

@implementation TVEpisodesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentTopItems = [ITunesFetcher topTVEpisodes];
}

@end
