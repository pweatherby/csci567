//
//  CalendarSectionsTableViewController.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/14/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarSectionsTableViewController.h"
#import <QuartzCore/QuartzCore.h> 

@interface CalendarSectionsTableViewController()

@property (strong, nonatomic) CalendarNumber* myNumber;
@end

@implementation CalendarSectionsTableViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.titleLabel setText:@""];
    [self.descrLabel setText:@""];
    if(self.myNumber)
    {
        [self.titleLabel setText:self.myNumber.courseTitleLDesc];
        [[self.titleLabel layer] setBorderColor:[[UIColor grayColor] CGColor]];
        [[self.titleLabel layer] setBorderWidth:1.0];
        [[self.titleLabel layer] setCornerRadius:15];
        [self.descrLabel setText:self.myNumber.courseDescription];
        [[self.descrLabel layer] setBorderColor:[[UIColor grayColor] CGColor]];
        [[self.descrLabel layer] setBorderWidth:1.0];
        [[self.descrLabel layer] setCornerRadius:15];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"sectionMtgPat"])
    {
        CalendarMeetingPatternsTableViewController* patController = [segue destinationViewController];
        NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
        if(indexPath && indexPath.item < [[self calendarData] count])
        {
            CalendarSection* t = [[self calendarData] objectAtIndex:indexPath.item];
            if(t)
            {
                patController.dataParam = t;
            }
        }
    }else{
        [super prepareForSegue:segue sender:sender];
    }
}


- (void) getCalendarData
{
    NSString* reqTerm = @"";
    NSString* reqSess = @"";
    NSString* reqCrsID = @"";
    NSString* reqCrsOfr = @"";
    if(self.dataParam && [self.dataParam isKindOfClass:[CalendarNumber class]])
    {
        self.myNumber = self.dataParam;
        reqTerm = self.myNumber.termCode;
        reqSess = self.myNumber.sessionGroupCode;
        reqCrsID = self.myNumber.courseID;
        reqCrsOfr = self.myNumber.courseOfferNbr;
    }
    self.calendarData = [CalendarSection currentSections:reqTerm
                                            SessionGroup:reqSess
                                                   CrsID:reqCrsID
                                                  CrsOfr:reqCrsOfr];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"ItemCell";
    CalendarSectionTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    UIButton* button = cell.CartButton;//x: button.frame.size.width*.3 y: button.frame.size.height*.5
    UILabel* lbl= [[UILabel alloc] initWithFrame:CGRectMake(8-(button.frame.size.width), 22, button.frame.size.height,button.frame.size.width)];
    lbl.transform = CGAffineTransformMakeRotation(-M_PI / 2);
  
    lbl.textColor =[UIColor blueColor];
    lbl.backgroundColor =[UIColor clearColor];
    lbl.text = @"Add";
    [lbl sizeToFit];
    [button addSubview:lbl];
    [button setHidden:YES];
    if(indexPath.item < [[self calendarData] count])
    {
        CalendarSection* t = [[self calendarData] objectAtIndex:indexPath.item];
        if(t && self.myNumber)
        {
            cell.keyLabel.text = [[[[self.myNumber.subjectCode stringByAppendingString:@" "]
                                    stringByAppendingString: self.myNumber.classNumber]
                                   stringByAppendingString: @"-"]
                                  stringByAppendingString: t.classSection];
            
            if( [t.classType isEqualToString:@"E"])
            {
                cell.regNbrLabel.text = [@"Reg Nbr: " stringByAppendingString:t.registrationNbr];
            }
            else
            {
                cell.regNbrLabel.text = [@"Assc Section: " stringByAppendingString:t.associatedClass];
            }
            cell.compLabel.text = t.componentLDesc;
            if ( [t.classStatus isEqualToString:@"A"])
            {
                if([t.enrlStatus isEqualToString:@"O"])
                {
                    cell.classStatusLabel.text = t.enrlStatusLDesc;
                }
                else if( t.waitCapacity > t.waitTotal)
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
                cell.classStatusLabel.text = t.classStatusLDesc;
            }
            cell.enrlLabel.text = [[t.enrlTotal stringByAppendingString:@" out of "] stringByAppendingString: t.enrlCapacity];
            cell.waitLabel.text = [[t.waitTotal stringByAppendingString:@" out of "] stringByAppendingString: t.waitCapacity];
            
        }
    }
    return cell;
}


- (IBAction)CartButtonPressed:(UIButton *)sender
{
}
@end
