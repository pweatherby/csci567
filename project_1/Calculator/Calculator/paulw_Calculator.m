//
//  paulw_Calculator.m
//  Calculator
//
//  Created by Paul Weatherby on 2/19/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "paulw_Calculator.h"

@implementation paulw_Calculator


@synthesize oper = _oper;

- (NSString*) oper{
    if(!_oper){
        _oper = [[NSString alloc] init];
    }
    return _oper;
}

@synthesize currentValue = _currentValue;

- (NSString*) currentValue{
    if(!_currentValue){
        _currentValue = [[NSString alloc] init];
    }
    return _currentValue;
}

- (void) AppendToCurrentValue:(NSString*)digit
{
    if([digit isEqual: @"."])
    {
       if([self.currentValue rangeOfString: digit].location != 0)
       {
           return;
       }
    }
    self.currentValue = [self.currentValue stringByAppendingString: digit];
}

- (void) RegisterBinaryOperator:(NSString*)oper
{
    
    if(![self.oper isEqualToString: @""])
    {
        [self EvaluateBinaryExpression];
    }
    
    self.left_operand = [self.currentValue doubleValue];
    self.oper = oper;
}

-(void) EvaluateBinaryExpression
{
    self.right_operand = [self.currentValue doubleValue];
    double d = 0.0;
    if([self.oper isEqual: @"+"])
    {
        d = (self.left_operand + self.right_operand);
    }
    else if([self.oper isEqual: @"-"])
    {
        d = (self.left_operand - self.right_operand);
    }
    else if([self.oper isEqual: @"*"])
    {
        d = (self.left_operand * self.right_operand);
    }
    
    self.left_operand = d;
    self.oper = [[NSString alloc] init];
    self.right_operand = 0.0;
    self.currentValue = [NSString stringWithFormat:@"%f",d];
    
}


- (void) Reset
{
    self.currentValue = [[NSString alloc] init];
    self.oper = [[NSString alloc] init];
    self.left_operand = 0.0;
    self.right_operand = 0.0;
}


- (void) StoreValue:(double)v
{
    self.storedValue = v;
}

- (double) RecallValue
{
    return self.storedValue;
}

- (void) ClearValue
{
    self.storedValue = 0;
}



@end
