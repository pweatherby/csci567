//
//  ITunesMediaItemDetailViewController.m
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "ITunesMediaItemDetailViewController.h"

@interface ITunesMediaItemDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView* detailImage;
@property (weak, nonatomic) IBOutlet UILabel* detailTitle;
@property (weak, nonatomic) IBOutlet UILabel* detailArtist;
@property (weak, nonatomic) IBOutlet UIButton* detailPrice;
@property (weak, nonatomic) IBOutlet UILabel* detailRank;
@property (weak, nonatomic) IBOutlet UILabel* detailCategory;
@property (weak, nonatomic) IBOutlet UILabel* detailReleaseDt;
- (IBAction)detailLinkPressed:(UIButton *)sender;

@end

@implementation ITunesMediaItemDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.detailItem.title;
    self.detailTitle.text = self.detailItem.title;
    self.detailArtist.text = self.detailItem.artist;
    [self.detailPrice setTitle: self.detailItem.price forState:UIControlStateNormal];
    self.detailImage.image = self.detailItem.artworkImage;
    self.detailRank.text = [NSString stringWithFormat:@"%d", self.detailItem.rank];
    self.detailCategory.text = self.detailItem.category;
    self.detailReleaseDt.text = self.detailItem.releaseDate;
}

- (IBAction)detailLinkPressed:(UIButton *)sender
{
    //[[UIApplication sharedApplication] openURL: self.detailItem.storeURL];
}
@end
