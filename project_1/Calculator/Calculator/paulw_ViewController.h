//
//  paulw_ViewController.h
//  Calculator
//
//  Created by Paul Weatherby on 2/19/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "paulw_Calculator.h"

@interface paulw_ViewController : UIViewController

@property (nonatomic) paulw_Calculator *calc;

@property (nonatomic) NSString *oper;

@property (nonatomic) double currentInput;
@property (nonatomic) bool continueCurrentInput;
@property (nonatomic) int currentDecimalCount;

@property (weak, nonatomic) IBOutlet UILabel *resultLbl;

@end
