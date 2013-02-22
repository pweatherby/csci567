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
- (void) EvaluteCurrentOperation;
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

- (void) EvaluteCurrentOperation
{
    if(![self.oper isEqualToString:@""])
    {
        if(![self.currentInput isEqualToString:@""])
        {
            if([self.oper isEqualToString:@"+"])
            {
                [self.calc Add: [self.currentInput doubleValue]];
            }
            else if([self.oper isEqualToString:@"-"])
            {
                [self.calc Subtract: [self.currentInput doubleValue]];
            }
            else if([self.oper isEqualToString:@"*"])
            {
                [self.calc Multiply: [self.currentInput doubleValue]];
            }
            else if([self.oper isEqualToString:@"/"])
            {
                [self.calc Divide: [self.currentInput doubleValue]];
            }
            self.currentInput = @"";
            self.oper = @"";
            self.resultLbl.text = [NSString stringWithFormat:@"%g", self.calc.currentValue];
        }
    }
  
}

- (IBAction)ButtonTapped:(UIButton *)sender
{
    switch(sender.tag)
    {
        // Numbers
        case 0:
            [self AppendToCurrentInput:@"0"];
            self.resultLbl.text = self.currentInput;
            break;
        case 1:
            [self AppendToCurrentInput:@"1"];
            self.resultLbl.text = self.currentInput;
            break;
        case 2:
            [self AppendToCurrentInput:@"2"];
            self.resultLbl.text = self.currentInput;
            break;
        case 3:
            [self AppendToCurrentInput:@"3"];
            self.resultLbl.text = self.currentInput;
            break;
        case 4:
            [self AppendToCurrentInput:@"4"];
            self.resultLbl.text = self.currentInput;
            break;
        case 5:
            [self AppendToCurrentInput:@"5"];
            self.resultLbl.text = self.currentInput;
            break;
        case 6:
            [self AppendToCurrentInput:@"6"];
            self.resultLbl.text = self.currentInput;
            break;
        case 7:
            [self AppendToCurrentInput:@"7"];
            self.resultLbl.text = self.currentInput;
            break;
        case 8:
            [self AppendToCurrentInput:@"8"];
            self.resultLbl.text = self.currentInput;
            break;
        case 9:
            [self AppendToCurrentInput:@"9"];
            self.resultLbl.text = self.currentInput;
            break;
        // Dot
        case 10:
            [self AppendToCurrentInput:@"."];
            self.resultLbl.text = self.currentInput;
            break;
        // Negate
        case 11:
            self.currentInput = [NSString stringWithFormat:@"%g", [self.calc Negate:[self.currentInput doubleValue]]];
            break;
        // Equals
        case 12:
            [self EvaluteCurrentOperation];
            break;
        // Plus
        case 13:
            if([self.currentInput isEqualToString:@""])
            {
                self.oper = @"+";
            }
            else if([self.oper isEqualToString:@""])
            {
                self.calc.currentValue = [self.currentInput doubleValue];
                self.oper = @"+";
                self.currentInput = @"";
            }
            else
            {
                [self EvaluteCurrentOperation];
                self.oper = @"+";
            }
            break;
        // Subtract
        case 14:
            if([self.currentInput isEqualToString:@""])
            {
                self.oper = @"-";
            }
            else if([self.oper isEqualToString:@""])
            {
                self.calc.currentValue = [self.currentInput doubleValue];
                self.oper = @"-";
                self.currentInput = @"";
            }
            else
            {
                [self EvaluteCurrentOperation];
                self.oper = @"-";
            }
            break;
        // Multiple
        case 15:
            if([self.currentInput isEqualToString:@""])
            {
                self.oper = @"*";
            }
            else if([self.oper isEqualToString:@""])
            {
                self.calc.currentValue = [self.currentInput doubleValue];
                self.oper = @"*";
                self.currentInput = @"";
            }
            else
            {
                [self EvaluteCurrentOperation];
                self.oper = @"*";
            }
            break;
        // Divide
        case 16:
            if([self.currentInput isEqualToString:@""])
            {
                self.oper = @"/";
            }
            else if([self.oper isEqualToString:@""])
            {
                self.calc.currentValue = [self.currentInput doubleValue];
                self.oper = @"/";
                self.currentInput = @"";
            }
            else
            {
                [self EvaluteCurrentOperation];
                self.oper = @"/";
            }
            break;
        // Sqrt
        case 17:
            self.currentInput = [NSString stringWithFormat:@"%g", [self.calc Sqrt:[self.currentInput doubleValue]]];
            break;
        // Inverse
        case 18:
            self.currentInput = [NSString stringWithFormat:@"%g", [self.calc Inverse:[self.currentInput doubleValue]]];
            break;
        // Memory Store
        case 19:
            [self.calc StoreValue: [self.currentInput doubleValue]];
            break;
        // Memory Retrieve
        case 20:
            self.currentInput = [NSString stringWithFormat:@"%g",[self.calc RecallValue]];
            break;
        // Memory Clear
        case 21:
            [self.calc ClearValue];
            break;
        // Constant: Pi
        case 22:
            self.currentInput = [NSString stringWithFormat:@"%g",[self.calc PI]];
            break;
        // Constant: e
        case 23:
            self.currentInput = [NSString stringWithFormat:@"%g",[self.calc E]];
            break;
        // Clear
        case 24:
            [self.calc Reset];
            self.currentInput = @"";
            self.oper = @"";
            break;
        default:
            break;
    }
    
}

@end
