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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *detailIndicator;

@end

@implementation ITunesMediaItemDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.detailItem)
    {
        [self.detailIndicator startAnimating];
        dispatch_queue_t q = dispatch_queue_create("image detail loading queue", NULL);
        dispatch_async(q, ^{
            UIImage* imageData = self.detailItem.artworkImage;
            // do something to get new data for this table view (which presumably takes time)
            dispatch_async(dispatch_get_main_queue(), ^{
            
                // update the view to the new data
                self.detailImage.image = [ImageUtils resizeImage:imageData withWidth:100 withHeight:100];;
                // and let the user know the refresh is over (stop spinner)
                [self.detailIndicator stopAnimating];
            });
        });
        self.title = self.detailItem.title;
        self.detailTitle.text = self.detailItem.title;
        self.detailArtist.text = self.detailItem.artist;
        [self.detailPrice setTitle: self.detailItem.price forState:UIControlStateNormal];
        self.detailRank.text = [NSString stringWithFormat:@"%d", self.detailItem.rank];
        self.detailCategory.text = self.detailItem.category;
        self.detailReleaseDt.text = self.detailItem.releaseDate;
    }
}

- (IBAction)detailLinkPressed:(UIButton *)sender
{
    if(self.detailItem)
    {
        if( self.detailItem.storeURL)
        {
            [[UIApplication sharedApplication] openURL: self.detailItem.storeURL];
        }
    }
}
@end
