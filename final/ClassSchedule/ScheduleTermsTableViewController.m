//
//  ScheduleTermsTableViewController.m
//  ClassSchedule
//
//  Created by iOS Student on 4/25/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "ScheduleTermsTableViewController.h"

@interface ScheduleTermsTableViewController ()

@property (nonatomic, strong) NSArray*  termData;

@end

@implementation ScheduleTermsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self reloadterms];
}



- (void) reloadterms
{
    // show the spinner if it's not already showing
    if( self.refreshControl)
    {
        [self.refreshControl beginRefreshing];
    }
    dispatch_queue_t q = dispatch_queue_create("table view loading queue", NULL);
    dispatch_async(q, ^{
        // do something to get new data for this table view (which presumably takes time)
        self.termData = [ScheduleTerm currentTerms];
        if(self.termData)
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.termData)
    {
        return [self.termData count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TermCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
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
