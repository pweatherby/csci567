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

- (void) RefreshCurrentTopItems
{
   self.currentTopItems = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self reloadTableViewData];
}

- (IBAction)refresh
{
    [self reloadTableViewData];
}

-(void) reloadTableViewData
{
    // show the spinner if it's not already showing
    if( self.refreshControl)
    {
        [self.refreshControl beginRefreshing];
    }
    dispatch_queue_t q = dispatch_queue_create("table view loading queue", NULL);
    dispatch_async(q, ^{
        // do something to get new data for this table view (which presumably takes time)
        [self RefreshCurrentTopItems];
        dispatch_async(dispatch_get_main_queue(), ^{
            // update the table view's Model to the new data, reloadData if necessary
            [self.tableView reloadData];
            // and let the user know the refresh is over (stop spinner)
            if(self.refreshControl)
            {
                [self.refreshControl endRefreshing];
            }
        });
    });
    
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
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    ITunesMediaItemTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Item"
                                                                         forIndexPath:indexPath];
    cell.ItemBigDesc.text = @"No Items Found";
    cell.ItemSmallDesc.text = @"";
    cell.ItemRank.text = @"";
    cell.ItemThumbnail.image = nil;
    if(self.currentTopItems)
    {
        ITunesMediaItem* curItem = [self.currentTopItems objectAtIndex:indexPath.item];
        cell.ItemBigDesc.text = curItem.title;
        cell.ItemSmallDesc.text = curItem.artist;
        cell.ItemRank.text = [NSString stringWithFormat:@"%d", curItem.rank];
        [cell.ItemIndicator startAnimating];
        dispatch_queue_t q = dispatch_queue_create("image loading queue", NULL);
        dispatch_async(q, ^{
            UIImage* imageData = curItem.artworkImage;
            // do something to get new data for this table view (which presumably takes time)
            dispatch_async(dispatch_get_main_queue(), ^{
                // update the table view's Model to the new data, reloadData if necessary
                cell.ItemThumbnail.image = imageData;
                // and let the user know the refresh is over (stop spinner)
                [cell.ItemIndicator stopAnimating];
            });
        });
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
