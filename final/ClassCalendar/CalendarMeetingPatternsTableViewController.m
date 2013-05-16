//
//  CalendarMeetingPatternsTableViewController.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/15/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarMeetingPatternsTableViewController.h"

@interface CalendarMeetingPatternsTableViewController ()

@end

@implementation CalendarMeetingPatternsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self reloadList];
}


- (void) reloadList
{
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.dataParam && self.dataParam.meetingPatterns)
    {
        return self.dataParam.meetingPatterns.count;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"ItemCell";
    CalendarMeetingPatternTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    CalendarSection* t = self.dataParam;

    if(t && indexPath.item < t.meetingPatterns.count)
    {
        CalendarMeetingPattern* pat = [t.meetingPatterns objectAtIndex:indexPath.item];
        if(pat)
        {
            cell.meetingPatLabel.text = pat.days;
            cell.startDateLabel.text = pat.startDateLDesc;
            cell.endDateLabel.text = pat.endDateLDesc;
            cell.startTimeLabel.text = [pat.startTime substringToIndex:5];
            cell.endDateLabel.text = [pat.endTime substringToIndex:5];
            
            NSString* insts = @"";
            for (int i = 0; i < pat.instructors.count; i++)
            {
                if( i > 0 )
                {
                    if( i + 1 == pat.instructors.count)
                    {
                        insts = [insts stringByAppendingString:@" and "];
                    }
                    else
                    {
                        
                        insts = [insts stringByAppendingString:@", "];
                    }
                }
                CalendarInstructor* inst = [pat.instructors objectAtIndex:i];
                insts = [[[insts stringByAppendingString: inst.firstName] stringByAppendingString:@" "] stringByAppendingString: inst.lastName];
            }
            cell.instructorsLabel.text = insts;
        }
    }
    return cell;
}


@end
