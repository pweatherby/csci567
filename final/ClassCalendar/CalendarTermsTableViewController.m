//
//  CalendarTermsTableViewController.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 4/25/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarTermsTableViewController.h"

@implementation CalendarTermsTableViewController

- (void) getCalendarData
{
    self.calendarData = [CalendarTerm currentTerms];

}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"ItemCell";
    CalendarTermTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if(indexPath.item < [[super calendarData] count])
    {
        CalendarTerm* t = [[super calendarData] objectAtIndex:indexPath.item];
        if(t)
        {
            cell.longDescLabel.text = t.longDesc;
        }
    }
    return cell;
}

@end
