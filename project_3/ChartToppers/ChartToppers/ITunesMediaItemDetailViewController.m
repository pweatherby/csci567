//
//  ITunesMediaItemDetailViewController.m
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "ITunesMediaItemDetailViewController.h"

@interface ITunesMediaItemDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel* detailTitle;

@end

@implementation ITunesMediaItemDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.detailItem.title;
    self.detailTitle.text = self.detailItem.title;
}

@end
