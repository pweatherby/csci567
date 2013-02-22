//
//  paulw_ViewController.m
//  Calculator
//
//  Created by Paul Weatherby on 2/19/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "paulw_ViewController.h"

@interface paulw_ViewController ()
- (IBAction)ButtonTapped:(UIButton *)sender;

@end

@implementation paulw_ViewController

@synthesize resultLbl;


@synthesize calc = _calc;

- (paulw_Calculator*) calc{
    if(!_calc){
        _calc = [[paulw_Calculator alloc] init];
    }
    return _calc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ButtonTapped:(UIButton *)sender
{
    switch(sender.tag)
    {
        // Numbers
        case 0:
            [self.calc AppendToCurrentValue:@"0"];
            break;
        case 1:
            [self.calc AppendToCurrentValue:@"1"];
            break;
        case 2:
            [self.calc AppendToCurrentValue:@"2"];
            break;
        case 3:
            [self.calc AppendToCurrentValue:@"3"];
            break;
        case 4:
            [self.calc AppendToCurrentValue:@"4"];
            break;
        case 5:
            [self.calc AppendToCurrentValue:@"5"];
            break;
        case 6:
            [self.calc AppendToCurrentValue:@"6"];
            break;
        case 7:
            [self.calc AppendToCurrentValue:@"7"];
            break;
        case 8:
            [self.calc AppendToCurrentValue:@"8"];
            break;
        case 9:
            [self.calc AppendToCurrentValue:@"9"];
            break;
        // Dot
        case 10:
            [self.calc AppendToCurrentValue:@"."];
            break;
        // Negate
        case 11:
            break;
        // Equals
        case 12:
            [self.calc EvaluateBinaryExpression];
            break;
        // Plus
        case 13:
            [self.calc RegisterBinaryOperator:@"+"];
            break;
        // Subtract
        case 14:
            [self.calc RegisterBinaryOperator:@"-"];
            break;
        // Multiple
        case 15:
            [self.calc RegisterBinaryOperator:@"*"];
            break;
        // Divide
        case 16:
            [self.calc RegisterBinaryOperator:@"/"];
            break;
        // Sqrt
        case 17:
            break;
        // Inverse
        case 18:
            break;
        // Memory Store
        case 19:
            [self.calc StoreValue];
            break;
        // Memory Retrieve
        case 20:
            [self.calc RecallValue];
            break;
        // Memory Clear
        case 21:
            [self.calc ClearValue];
            break;
        // Constant: Pi
        case 22:
            break;
        // Constant: e
        case 23:
            break;
        // Clear
        case 24:
            [self.calc Reset];
            break;
        default:
            break;
    }
    self.resultLbl.text = self.calc.currentValue;
}

@end
