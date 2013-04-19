//
//  ITunesMediaItemsTableViewController.h
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITunesMediaItemDetailViewController.h"
#import "ITunesMediaItemTableViewCell.h"
#import "ITunesMediaItem.h"

@interface ITunesMediaItemsTableViewController : UITableViewController

@property (strong, nonatomic) NSArray* currentTopItems;

- (void) reloadTableViewData;

@end
