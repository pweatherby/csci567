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

- (double) Add:(double)d;
- (double) Subtract:(double)d;
- (double) Multiply:(double)d;
- (double) Divide:(double)d;
- (double) Power:(double)d;


- (double) Negate:(double)d;
- (double) Sqrt:(double)d;
- (double) Inverse:(double)d;

- (void) Reset;

- (void) StoreValue:(double)d;
- (double) RecallValue;
- (void) ClearValue;

- (double) PI;
- (double) E;

@end
