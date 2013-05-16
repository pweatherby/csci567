//
//  CalendarListTableViewController.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/2/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarListTableViewController.h"

@interface CalendarListTableViewController ()

- (IBAction)refreshButtonPressed:(id)sender;

@end

@implementation CalendarListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.refreshControl)
    {
        [self.refreshControl addTarget:self
                                action:@selector(reloadList)
                      forControlEvents:UIControlEventValueChanged];
    }
    [self reloadList];
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"nextList"]) {
        CalendarListTableViewController* nextViewController = [segue destinationViewController];
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        if(self.calendarData && indexPath.row < self.calendarData.count)
        {
            nextViewController.dataParam = [self.calendarData objectAtIndex:indexPath.row];
        }
    }
}

- (IBAction)refreshButtonPressed:(id)sender
{
    [self reloadList];
}

#pragma mark - Get/Refresh Data Listing

- (void) getCalendarData
{
    self.calendarData = nil;
}

- (void) reloadList
{
    // show the spinner if it's not already showing
    if( self.refreshControl)
    {
        [self.refreshControl beginRefreshing];
    }
    dispatch_queue_t q = dispatch_queue_create("table view loading queue", NULL);
    dispatch_async(q, ^{
        // do something to get new data for this table view (which presumably takes time)
        [self getCalendarData];
        if(self.calendarData)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                // update the table view's Model to the new data, reloadData if necessary
                [self.tableView reloadData];
                // and let the user know the refresh is over (stop spinner)
                if(self.refreshControl)
                {
                    [self.refreshControl endRefreshing];
                }
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString* message = @"A network connection cannot be detected. Please confirm that you have an active network connection and try again.";
                // update the table view's Model to the new data, reloadData if necessary
                UIAlertView* uav = [[UIAlertView alloc] initWithTitle:@"Network Error"
                                                              message:message
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
                [uav show];
                // and let the user know the refresh is over (stop spinner)
                if(self.refreshControl)
                {
                    [self.refreshControl endRefreshing];
                }
            });
        }
    });
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.calendarData)
    {
        return [self.calendarData count];
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    // Default-- Should be overwritten
    static NSString* CellIdentifier = @"ItemCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}


@end
