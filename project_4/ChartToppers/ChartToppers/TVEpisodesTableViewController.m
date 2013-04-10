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
    [self.refreshControl addTarget:self
                            action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
    [super viewDidLoad];
}

- (void) RefreshCurrentTopItems
{
    self.currentTopItems = [ITunesFetcher topTVEpisodes];
}

@end
