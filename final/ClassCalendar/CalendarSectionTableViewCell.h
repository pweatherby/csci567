//
//  CalendarSectionTableViewCell.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/14/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarSectionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* keyLabel;
@property (weak, nonatomic) IBOutlet UILabel* regMethodLabel;
@property (weak, nonatomic) IBOutlet UILabel* regNbrLabel;
@property (weak, nonatomic) IBOutlet UILabel* compLabel;
@property (weak, nonatomic) IBOutlet UILabel* asscClassLabel;

@property (weak, nonatomic) IBOutlet UILabel* classStatusLabel;

@end
