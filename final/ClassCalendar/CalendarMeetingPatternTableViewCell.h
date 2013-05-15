//
//  CalendarMeetingPatternTableViewCell.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/15/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarMeetingPatternTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel* meetingPatLabel;
@property (weak, nonatomic) IBOutlet UILabel* startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel* endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel* startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel* endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel* instructorsLabel;

@end
