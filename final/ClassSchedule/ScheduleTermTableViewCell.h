//
//  ScheduleTermTableViewCell.h
//  ClassSchedule
//
//  Created by iOS Student on 4/25/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleTermTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* abbrevLabel;
@property (weak, nonatomic) IBOutlet UILabel* longDescLabel;
@property (weak, nonatomic) IBOutlet UILabel* regDatesLabel;

@end
