//
//  CalendarNumberTableViewCell.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/14/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarNumberTableViewCell : UITableViewCell

    @property (weak, nonatomic) IBOutlet UILabel* titleLabel;
    @property (weak, nonatomic) IBOutlet UILabel* numberLabel;
    @property (weak, nonatomic) IBOutlet UILabel* unitsLabel;

@end
