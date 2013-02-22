//
//  paulw_Calculator.m
//  Calculator
//
//  Created by Paul Weatherby on 2/19/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "paulw_Calculator.h"

@implementation paulw_Calculator

- (NSDouble) Add:(NSDouble)d
{
   self.currentValue = self.currentValue + d;
   return self.currentValue;
}

- (NSDouble) Subtract:(NSDouble)d
{
   self.currentValue = self.currentValue - d;
   return self.currentValue;
}

- (NSDouble) Multiply:(NSDouble)d
{
   self.currentValue = self.currentValue * d;
   return self.currentValue;
}
- (NSDouble) Divide:(NSDouble)d
{
   if(d == 0)
   { return self.currentValue; }
   self.currentValue = self.currentValue / d;
   return self.currentValue;
}

- (NSDouble) Negate:(NSDouble)d
{
   return 0 - d;
}

- (void) Reset
{
    self.left_operand = 0.0;
}


- (void) StoreValue
{
    self.storedValue = self.currentValue;
}

- (NSDouble) RecallValue
{
    self.currentValue = self.storedValue;
}

- (void) ClearValue
{
    self.storedValue = 0.0;
}



@end
