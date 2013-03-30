//
//  ITunesMediaItemsTableViewController.m
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "ITunesMediaItemsTableViewController.h"

@interface ITunesMediaItemsTableViewController ()



@end

@implementation ITunesMediaItemsTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.currentTopItems)
    {
        return self.currentTopItems.count;
    }
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    ITunesMediaItemTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Item" forIndexPath:indexPath];
    cell.ItemBigDesc.text = @"No Items Found";
    cell.ItemSmallDesc.text = @"";
    cell.ItemRank.text = @"";
    if(self.currentTopItems)
    {
        ITunesMediaItem* curItem = [self.currentTopItems objectAtIndex:indexPath.item];
        cell.ItemBigDesc.text = curItem.title;
        cell.ItemSmallDesc.text = curItem.artist;
        cell.ItemRank.text = [NSString stringWithFormat:@"%d", curItem.rank];
    }
    return cell;
}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.currentTopItems)
    {
        ITunesMediaItem* curItem = [self.currentTopItems objectAtIndex:indexPath.item];
        if(curItem)
        {
            [self performSegueWithIdentifier: @"showDetail"
                                      sender: curItem];
            
        }
    }
}

- (void) prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        ITunesMediaItemDetailViewController* detailView = [segue destinationViewController];
        detailView.detailItem = sender;
    }
}

@end
