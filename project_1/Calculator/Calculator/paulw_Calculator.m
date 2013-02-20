//
//  paulw_Calculator.m
//  Calculator
//
//  Created by Paul Weatherby on 2/19/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "paulw_Calculator.h"

@implementation paulw_Calculator

- (void) AddToCurrentValue:(double)ro
{
    self.currentValue = self.currentValue + ro;
}

- (void) SubtractFromCurrentValue:(double)ro
{
    self.currentValue = self.currentValue - ro;
}
- (void) MultipleByCurrentValue:(double)ro
{
    self.currentValue = self.currentValue * ro;
}

- (void) DivideFromCurrentValue:(double)ro
{
    if( ro != 0)
    {
        self.currentValue = self.currentValue / ro;
    }
    else
    {
        self.currentValue = 0;
    }
}

- (void) SquareRoot
{
    if( self.currentValue > 0)
    {
        self.currentValue =  sqrt(self.currentValue);
    }
    else
    {
        self.currentValue = 0;
    }
}
- (void) Inverse
{
    if(self.currentValue != 0)
    {
       self.currentValue = 1/self.currentValue;
    }
    else
    {
        self.currentValue = 0;
    }
}

- (double) Negate:(double)o
{
    return 0 - o;
}

- (void) Reset
{
    self.currentValue = 0;
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
