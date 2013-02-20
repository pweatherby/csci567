//
//  paulw_Calculator.h
//  Calculator
//
//  Created by Paul Weatherby on 2/19/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface paulw_Calculator : NSObject

@property double currentValue;

@property double storedValue;


- (void) AddToCurrentValue:(double)ro;
- (double) SubtractFromCurrentValue:(double)ro;
- (double) MultipleByCurrentValue:(double)ro;
- (double) DivideFromCurrentValue:(double)ro;

- (double) SquareRoot;
- (double) Inverse:(double)o;

- (double) Negate:(double)o;

@end
