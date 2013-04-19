//
//  ITunesMediaItemTableViewCell.h
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITunesMediaItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView*             ItemThumbnail;
@property (weak, nonatomic) IBOutlet UILabel*                 ItemBigDesc;
@property (weak, nonatomic) IBOutlet UILabel*                 ItemSmallDesc;
@property (weak, nonatomic) IBOutlet UILabel*                 ItemRank;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView* ItemIndicator;

@end
