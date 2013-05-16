//
//  CalendarSessionGroupTableViewController.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/13/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarSessionGroupTableViewController.h"

@implementation CalendarSessionGroupTableViewController

- (void) getCalendarData
{
    NSString* reqTerm = @"";
    if(self.dataParam && [self.dataParam isKindOfClass:[CalendarTerm class]])
    {
        CalendarTerm* t = self.dataParam;
        reqTerm = t.code;
    }
    self.calendarData = [CalendarSessionGroup currentSessionGroups:reqTerm];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"ItemCell";
    CalendarSessionGroupTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if(indexPath.item < [[super calendarData] count])
    {
        CalendarSessionGroup* t = [[super calendarData] objectAtIndex:indexPath.item];
        if(t)
        {
            cell.longDescLabel.text = t.longDesc;
        }
    }
    return cell;
}

@end
