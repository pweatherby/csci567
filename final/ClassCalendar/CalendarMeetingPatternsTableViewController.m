//
//  CalendarMeetingPatternsTableViewController.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/15/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarMeetingPatternsTableViewController.h"

@interface CalendarMeetingPatternsTableViewController ()

@property (strong, nonatomic) CalendarSection* mySection;

@end

@implementation CalendarMeetingPatternsTableViewController

- (id) initWithCalendarSection: (CalendarSection*) section
{
    self = [super init];
    if (self)
    {
        self.mySection = section;
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    if(self.mySection)
    {

    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.mySection && self.mySection.meetingPatterns)
    {
        return self.mySection.meetingPatterns.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ItemCell";
    CalendarMeetingPatternTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    CalendarSection* t = self.mySection;

    if(t && indexPath.item < t.meetingPatterns.count)
    {
        CalendarMeetingPattern* pat = [t.meetingPatterns objectAtIndex:indexPath.item];
        if(pat)
        {
            cell.keyLabel.text = @"";
            
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
            cell.enrlLabel.text = [[t.enrlTotal stringByAppendingString:@" out of "] stringByAppendingString: t.enrlCapacity];
            cell.waitLabel.text = [[t.waitTotal stringByAppendingString:@" out of "] stringByAppendingString: t.waitCapacity];
        }
    }
    return cell;
}


@end
