//
//  paulw_Calculator.m
//  Calculator
//
//  Created by Paul Weatherby on 2/19/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "paulw_Calculator.h"

@implementation paulw_Calculator

- (double) Add:(double)d
{
   self.currentValue = self.currentValue + d;
   return self.currentValue;
}

- (double) Subtract:(double)d
{
   self.currentValue = self.currentValue - d;
   return self.currentValue;
}

- (double) Multiply:(double)d
{
   self.currentValue = self.currentValue * d;
   return self.currentValue;
}
- (double) Divide:(double)d
{
   if(d == 0)
   { return self.currentValue; }
   self.currentValue = self.currentValue / d;
   return self.currentValue;
}

- (double) Power:(double)d
{
    self.currentValue = pow(self.currentValue, d);
    return self.currentValue;
}

- (double) Negate:(double)d
{
   return 0 - d;
}

- (double) Sqrt:(double)d
{
    return sqrt(d);
}
- (double) Inverse:(double)d
{
    if(d == 0)
    {
        return 1;
    }
    return 1/d;
}

- (void) Reset
{
    self.currentValue = 0.0;
}


- (void) StoreValue:(double)d
{
    self.storedValue = d;
}

- (double) RecallValue
{
    return self.storedValue;
}

- (void) ClearValue
{
    self.storedValue = 0.0;
}

- (double)PI
{
    return M_PI;
}

- (double) E
{
    return M_E;
}

@end
