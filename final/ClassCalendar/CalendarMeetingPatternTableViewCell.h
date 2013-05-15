//
//  CalendarMeetingPatternTableViewCell.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/15/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarMeetingPatternTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* keyLabel;
@property (weak, nonatomic) IBOutlet UILabel* regNbrLabel;
@property (weak, nonatomic) IBOutlet UILabel* compLabel;
@property (weak, nonatomic) IBOutlet UILabel* classStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel* enrlLabel;
@property (weak, nonatomic) IBOutlet UILabel* waitLabel;

@end
