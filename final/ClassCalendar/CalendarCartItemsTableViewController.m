//
//  CalendarCartItemsTableViewController.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/15/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarCartItemsTableViewController.h"

@interface CalendarCartItemsTableViewController ()

@property (strong, nonatomic) ShopCartManager* cart;

@end

@implementation CalendarCartItemsTableViewController


- (UINavigationItem*)navigationItem{
    UINavigationItem* item = [super navigationItem];
    if (item != nil && item.backBarButtonItem == nil)
    {
        item.backBarButtonItem = [[UIBarButtonItem alloc] init];
        item.backBarButtonItem.title = [self title];
    }
    
    return item;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cart = [[ShopCartManager alloc] initWithDevice:[UserProfile GetDeviceID]
                                                withKey:[UserProfile GetValetKey]];
    if(self.refreshControl)
    {
        [self.refreshControl addTarget:self
                                action:@selector(reloadList)
                      forControlEvents:UIControlEventValueChanged];
    }
    [self reloadList];
    UIColor* bkg = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"body-bkg-pixel.jpg"]];
    // initWithHue:22.34f saturation:97.86f brightness:54.9f alpha:1.0f];
    // initWithRed:(140.0/256) green:(54.0/256) blue:(3.0/256) alpha:1.0f];
    self.tableView.backgroundColor = bkg;
    
    UIImageView* view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"body-bkg.png"]];
    view.contentMode = UIViewContentModeTop;
    self.tableView.backgroundView = view;
}

#pragma mark - Get/Refresh Data Listing

- (void) getCartData
{
    self.cartData = [self.cart currentCart];
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
        [self getCartData];
        if(self.cartData)
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
                NSString* message = @"Unable to retrieve Enrollment Cart. Check Network Connection or Request New Access in Profile Page.";
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"sectionMtgPat"])
    {
        CalendarMeetingPatternsTableViewController* patController = [segue destinationViewController];
        NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
        if(indexPath && indexPath.item < [[self cartData] count])
        {
            ShopCartItem* t = [[self cartData] objectAtIndex:indexPath.item];
            if(t)
            {
                CalendarSection* s = t.section;
                if(s)
                {
                    patController.dataParam = s;
                }
            }
        }
    }else{
        [super prepareForSegue:segue sender:sender];
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.cartData)
    {
        return [self.cartData count];
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    static NSString* CellIdentifier = @"ItemCell";
    ShopCartItemTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(cell)
    {
        // Configure the cell...
        UIButton* button = cell.CartButton;
        UILabel* lbl= [[UILabel alloc] initWithFrame:CGRectMake(10-(button.frame.size.width), 52, button.frame.size.height,button.frame.size.width)];
        lbl.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        
        lbl.textColor =[UIColor blueColor];
        lbl.backgroundColor =[UIColor clearColor];
        lbl.text = @"Remove";
        [lbl sizeToFit];
        [button addSubview:lbl];
        [button setHidden:YES];
        if(indexPath.item < [[self cartData] count])
        {
            ShopCartItem* t = [[self cartData] objectAtIndex:indexPath.item];
            if(t)
            {
                cell.termLabel.text = [t.term longDesc];
                cell.sessionGroupLabel.text = [t.sessionGroup longDesc];
                cell.titleLabel.text = [t.number courseTitleSDesc];
                cell.keyLabel.text = [[[[[t.subject subjectCode] stringByAppendingString:@" "]
                                                                 stringByAppendingString:[t.number classNumber]]
                                                                 stringByAppendingString:@"-"]
                                                                 stringByAppendingString:[t.section classSection]];
                if( [t.section.classType isEqualToString:@"E"])
                {
                    cell.regNbrLabel.text = [@"Reg Nbr: " stringByAppendingString:t.section.registrationNbr];
                }
                else
                {
                    cell.regNbrLabel.text = @"";//[@"Assc Section: " stringByAppendingString:t.section.associatedClass];
                }
                cell.compLabel.text = t.section.componentLDesc;
                if ( [t.section.classStatus isEqualToString:@"A"])
                {
                    if([t.section.enrlStatus isEqualToString:@"O"])
                    {
                        cell.classStatusLabel.text = t.section.enrlStatusLDesc;
                    }
                    else if( t.section.waitCapacity > t.section.waitTotal)
                    {
                        cell.classStatusLabel.text = @"WaitList";
                    }
                    else
                    {
                        cell.classStatusLabel.text = @"Full";
                    }
                }
                else
                {
                    cell.classStatusLabel.text = t.section.classStatusLDesc;
                }
                cell.enrlLabel.text = [[t.section.enrlTotal stringByAppendingString:@" out of "] stringByAppendingString: t.section.enrlCapacity];
                cell.waitLabel.text = [[t.section.waitTotal stringByAppendingString:@" out of "] stringByAppendingString: t.section.waitCapacity];
            }
        }
    }
    return cell;
}

- (IBAction)RefreshPressed:(UIBarButtonItem *)sender
{
    [self reloadList];
}
@end
