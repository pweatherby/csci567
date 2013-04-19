//
//  ITunesMediaItemDetailViewController.h
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIActivity.h>
#import "ITunesMediaItem.h"
#import "ImageUtils.h"
#import "FavoritesManager.h"

@interface ITunesMediaItemDetailViewController : UITableViewController <UITableViewDelegate>

@property (strong, nonatomic) ITunesMediaItem* detailItem;

@end
