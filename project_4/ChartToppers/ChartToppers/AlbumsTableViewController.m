//
//  AlbumsTableViewController.m
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "AlbumsTableViewController.h"

@interface AlbumsTableViewController ()

@end

@implementation AlbumsTableViewController

- (void)viewDidLoad
{
    [self.refreshControl addTarget:self
                            action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
    [super viewDidLoad];
}

- (void) RefreshCurrentTopItems
{
    self.currentTopItems = [ITunesFetcher topAlbums];
}

@end
