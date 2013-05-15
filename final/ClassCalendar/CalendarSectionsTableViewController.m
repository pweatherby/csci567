//
//  CalendarSectionsTableViewController.m
//  ClassCalendar
//
//  Created by iOS Student on 5/14/13.
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ItemCell";
    CalendarSectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    [cell.classStatusLabel setTransform: CGAffineTransformMakeRotation (-3.14/2)];
    if(indexPath.item < [[super calendarData] count])
    {
        CalendarSection* t = [[super calendarData] objectAtIndex:indexPath.item];
        if(t && self.myNumber)
        {
            cell.keyLabel.text = [[[[self.myNumber.subjectCode stringByAppendingString:@" "]
                                                                  stringByAppendingString: self.myNumber.classNumber]
                                                                  stringByAppendingString: @" "]
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
                    cell.classStatusLabel.text = [t.enrlStatusLDesc uppercaseString];
                }
                else if( t.waitCapacity > t.waitTotal)
                {
                    cell.classStatusLabel.text = @"WAITLIST";
                }
                else
                {
                    cell.classStatusLabel.text = @"FULL";
                }
            }
            else
            {
                cell.classStatusLabel.text = [t.classStatusLDesc uppercaseString];
            }
        }
    }
    return cell;
}


@end