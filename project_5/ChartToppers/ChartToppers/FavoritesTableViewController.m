//
//  FavoritesTableViewController.m
//  ChartToppers
//
//  Created by Paul Weatherby on 4/15/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "FavoritesTableViewController.h"

@interface FavoritesTableViewController ()

@end

@implementation FavoritesTableViewController


- (void) RefreshCurrentTopItems
{
    self.currentTopItems = [[FavoritesManager sharedFavoritesManager] allFavorites];
}

@end
