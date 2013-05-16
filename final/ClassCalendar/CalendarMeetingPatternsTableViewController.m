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
        return self.dataParam.meetingPatterns.count > 0 ? self.dataParam.meetingPatterns.count  : 1;
    }
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"ItemCell";
    CalendarMeetingPatternTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.meetingPatLabel.text = @"TBA";
    CalendarSection* t = self.dataParam;

    if(t && indexPath.item < t.meetingPatterns.count)
    {
        CalendarMeetingPattern* pat = [t.meetingPatterns objectAtIndex:indexPath.item];
        if(pat)
        {
            cell.meetingPatLabel.text = pat.days;
            cell.startDateLabel.text = pat.startDateLDesc;
            cell.endDateLabel.text = pat.endDateLDesc;
            cell.startTimeLabel.text = [pat.startTime length] > 5 ? [pat.startTime substringToIndex:5] : pat.startTime;
            cell.endTimeLabel.text = [pat.endTime length] > 5 ? [pat.endTime substringToIndex:5] : pat.endTime;
            
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
            if([insts isEqualToString:@""])
            {
                insts = @"TBA";
            }
            cell.instructorsLabel.text = insts;
        }
    }
    return cell;
}


@end
