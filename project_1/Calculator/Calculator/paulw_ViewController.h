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

@property (strong, nonatomic) paulw_Calculator *calc;

@property (strong, nonatomic) NSString *oper;

@property (strong, nonatomic) NSString *currentInput;

@property (weak, nonatomic) IBOutlet UILabel *resultLbl;

@end
