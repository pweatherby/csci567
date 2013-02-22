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

@synthesize oper = _oper;

- (NSString*) oper{
    if(!_oper){
        _oper = [[NSString alloc] init];
    }
    return _oper;
}

@synthesize currentInput = _currentInput;

- (NSString*) currentInput{
    if(!_currentInput){
        _currentInput = [[NSString alloc] init];
    }
    return _currentInput;
}

- (void) AppendToCurrentInput:(NSString*)digit
{
    if([digit isEqual: @"."])
    {
       if([self.currentInput rangeOfString: digit].location != 0)
       {
           return;
       }
    }
    self.currentInput = [self.currentInput stringByAppendingString: digit];
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
            [self AppendToCurrentInput:@"0"];
            break;
        case 1:
            [self AppendToCurrentInput:@"1"];
            break;
        case 2:
            [self AppendToCurrentInput:@"2"];
            break;
        case 3:
            [self AppendToCurrentInput:@"3"];
            break;
        case 4:
            [self AppendToCurrentInput:@"4"];
            break;
        case 5:
            [self AppendToCurrentInput:@"5"];
            break;
        case 6:
            [self AppendToCurrentInput:@"6"];
            break;
        case 7:
            [self AppendToCurrentInput:@"7"];
            break;
        case 8:
            [self AppendToCurrentInput:@"8"];
            break;
        case 9:
            [self AppendToCurrentInput:@"9"];
            break;
        // Dot
        case 10:
            [self AppendToCurrentInput:@"."];
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
