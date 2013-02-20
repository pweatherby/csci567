//
//  paulw_Calculator.h
//  Calculator
//
//  Created by Paul Weatherby on 2/19/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface paulw_Calculator : NSObject

@property (nonatomic) double currentValue;

@property (nonatomic) double storedValue;


- (void) AddToCurrentValue:(double)ro;
- (void) SubtractFromCurrentValue:(double)ro;
- (void) MultipleByCurrentValue:(double)ro;
- (void) DivideFromCurrentValue:(double)ro;

- (void) SquareRoot;
- (void) Inverse;

- (double) Negate:(double)o;

- (void) Reset;


- (void) StoreValue:(double)v;
- (double) RecallValue;
- (void) ClearValue;


@end
