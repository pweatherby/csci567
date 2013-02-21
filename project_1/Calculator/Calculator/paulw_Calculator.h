//
//  paulw_Calculator.h
//  Calculator
//
//  Created by Paul Weatherby on 2/19/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface paulw_Calculator : NSObject



@property (nonatomic) double left_operand;

@property (nonatomic) NSString *oper;

@property (nonatomic)  double right_operand;


@property (nonatomic) NSString *currentValue;

@property (nonatomic) double storedValue;


- (void) Evaluate;

- (void) AppendToCurrentValue:(NSString*)digit;

- (void) RegisterOperator:(NSString*)oper;

- (void) Reset;


- (void) StoreValue:(double)v;
- (double) RecallValue;
- (void) ClearValue;


@end
