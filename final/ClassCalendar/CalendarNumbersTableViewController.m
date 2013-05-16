//
//  CalendarNumbersTableViewController.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/14/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarNumbersTableViewController.h"

@implementation CalendarNumbersTableViewController

- (void) getCalendarData
{
    NSString* reqTerm = @"";
    NSString* reqSess = @"";
    NSString* reqSubj = @"";
    if(self.dataParam && [self.dataParam isKindOfClass:[CalendarSubject class]])
    {
        CalendarSubject* t = self.dataParam;
        reqTerm = t.termCode;
        reqSess = t.sessionGroupCode;
        reqSubj = t.subjectCode;
    }
    self.calendarData = [CalendarNumber currentNumbers:reqTerm
                                          SessionGroup:reqSess
                                               Subject:reqSubj];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"ItemCell";
    CalendarNumberTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if(indexPath.item < [[super calendarData] count])
    {
        CalendarNumber* t = [[super calendarData] objectAtIndex:indexPath.item];
        if(t)
        {
            cell.numberLabel.text = [[t.subjectCode stringByAppendingString:@" "] stringByAppendingString: t.classNumber];
            if([t.unitsRange isEqualToString:@"1"])
            {
                cell.unitsLabel.text = [t.unitsRange stringByAppendingString:@" unit"];
            }
            else
            {
                cell.unitsLabel.text = [t.unitsRange stringByAppendingString:@" units"];
            }
            cell.titleLabel.text = t.courseTitleLDesc;
        }
    }
    return cell;
}


@end
