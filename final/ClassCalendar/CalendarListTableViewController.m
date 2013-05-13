//
//  CalendarListTableViewController.m
//  ClassCalendar
//
//  Created by iOS Student on 5/2/13.
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
    [self reloadList];
    UIColor* bkg = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"body-bkg-pixel.jpg"]];
                                    // initWithHue:22.34f saturation:97.86f brightness:54.9f alpha:1.0f];
                                    // initWithRed:(140.0/256) green:(54.0/256) blue:(3.0/256) alpha:1.0f];
    self.tableView.backgroundColor = bkg;
    
    UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"body-bkg.png"]];
    view.contentMode = UIViewContentModeTop;
    self.tableView.backgroundView = view;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.calendarData)
    {
        return [self.calendarData count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Default-- Should be overwritten
    static NSString *CellIdentifier = @"ItemCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
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
