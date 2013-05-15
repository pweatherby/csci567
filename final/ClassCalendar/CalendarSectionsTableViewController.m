//
//  CalendarSectionsTableViewController.m
//  ClassCalendar
//
//  Created by iOS Student on 5/14/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarSectionsTableViewController.h"

@interface CalendarSectionsTableViewController()

@property (strong, nonatomic) CalendarNumber* myNumber;
@end

@implementation CalendarSectionsTableViewController

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
    if(indexPath.item < [[super calendarData] count])
    {
        CalendarSection* t = [[super calendarData] objectAtIndex:indexPath.item];
        if(t && self.myNumber)
        {
            cell.numberLabel.text = [[[[self.myNumber.subjectCode stringByAppendingString:@" "]
                                                                  stringByAppendingString: self.myNumber.classNumber]
                                                                  stringByAppendingString: @" "]
                                                                  stringByAppendingString: t.classSection];
            
            cell.unitsLabel.text = t.registrationNbr;
            cell.titleLabel.text = t.componentLDesc;
        }
    }
    return cell;
}


@end
