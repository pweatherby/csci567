//
//  CalendarSubjectTableViewCell.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/13/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarSubjectTableViewCell : UITableViewCell

    @property (weak, nonatomic) IBOutlet UILabel* formalDescLabel;
    @property (weak, nonatomic) IBOutlet UILabel* shortDescLabel;

@end
