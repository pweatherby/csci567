//
//  ITunesMediaItemDetailViewController.h
//  ChartToppers
//
//  Created byPaul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITunesMediaItem.h"

@interface ITunesMediaItemDetailViewController : UITableViewController

@property (strong, nonatomic) ITunesMediaItem* detailItem;

@end
