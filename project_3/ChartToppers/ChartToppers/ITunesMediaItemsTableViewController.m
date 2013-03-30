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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(self.currentTopItems)
    {
        return self.currentTopItems.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ITunesMediaItemTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"IOSAppsItem" forIndexPath:indexPath];
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
