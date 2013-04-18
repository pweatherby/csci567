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
- (IBAction)shareButtonPressed:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextView *detailSummary;

@end

@implementation ITunesMediaItemDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.detailItem)
    {
        [self.detailIndicator startAnimating];
        self.detailImage.image = nil;
        dispatch_queue_t q = dispatch_queue_create("image detail loading queue", NULL);
        dispatch_async(q, ^{
            UIImage* imageData = self.detailItem.artworkImage;
            // do something to get new data for this table view (which presumably takes time)
            dispatch_async(dispatch_get_main_queue(), ^{
            
                self.detailImage.image = imageData;
                // update the view to the new data
                /* // This was just not working like i want
                   // but i tried
                CGRect rect = CGRectMake(0, 0, 100, 100);
                self.detailImage.image = [ImageUtils cropImage:imageData toRect:rect];
                */
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
        self.detailSummary.text = self.detailItem.summary;
        if([self.detailSummary.text isEqualToString:@""])
        {
            self.detailSummary.text = @"No Summary Available";
        }
        
        CGRect frame = self.detailSummary.frame;
        frame.size.height = self.detailSummary.contentSize.height;
        [self.detailSummary setFrame:frame];
        [self.detailSummary setNeedsDisplay];
        bool isFav = [[FavoritesManager sharedFavoritesManager] isFavorite:self.detailItem];
        if(isFav)
        {
            
        }
        else
        {
            
        }
    }
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float h = 45;   
    if(indexPath.section == 1 && indexPath.row == 0)
    {
        h = self.detailSummary.frame.size.height;
    }
    NSLog(@"h: %f", h);
    return h;
}

- (IBAction)detailLinkPressed:(UIButton *)sender
{
    if(self.detailItem)
    {
        if( self.detailItem.storeURL)
        {
            UIApplication* commonApp = [UIApplication sharedApplication];
            if( commonApp )
            {
                [commonApp openURL: self.detailItem.storeURL];
            }
        }
    }
}

- (IBAction)shareButtonPressed:(UIBarButtonItem *)sender
{
    NSArray* itemSharableFields = [[NSArray alloc] initWithObjects: self.detailItem.title, nil];//]self.detailItem.artworkImage, nil];
    NSArray* shareWithApps = [[NSArray alloc] initWithObjects: UIActivityTypeMail, UIActivityTypePostToFacebook, UIActivityTypePostToTwitter, nil];
    UIActivityViewController* activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemSharableFields
                                                                             applicationActivities:shareWithApps];
    
    [self presentViewController:activityVC
                       animated:YES
                     completion:nil];
}
@end
