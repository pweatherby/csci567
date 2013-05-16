//
//  CalendarSubjectsTableViewController.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/13/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarSubjectsTableViewController.h"

@implementation CalendarSubjectsTableViewController

- (void) getCalendarData
{
    NSString* reqTerm = @"";
    NSString* reqSess = @"";
    if(self.dataParam && [self.dataParam isKindOfClass:[CalendarSessionGroup class]])
    {
        CalendarSessionGroup* t = self.dataParam;
        reqTerm = t.termCode;
        reqSess = t.sessionGroupCode;
    }
    self.calendarData = [CalendarSubject currentSubjects:reqTerm
                                            SessionGroup:reqSess];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"ItemCell";
    CalendarSubjectTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if(indexPath.item < [[super calendarData] count])
    {
        CalendarSubject* t = [[super calendarData] objectAtIndex:indexPath.item];
        if(t)
        {
            cell.formalDescLabel.text = t.formalDesc;
            cell.shortDescLabel.text = t.shortDesc;
        }
    }
    return cell;
}

@end
