//
//  paulw_Calculator.h
//  Calculator
//
//  Created by Paul Weatherby on 2/19/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface paulw_Calculator : NSObject



@property (strong, nonatomic) double left_operand;

@property (strong, nonatomic) NSString *oper;

@property (strong, nonatomic)  double right_operand;


@property (strong, nonatomic) NSString *currentValue;

@property (strong, nonatomic) NSString *storedValue;


- (void) EvaluateBinaryExpression;

- (void) AppendToCurrentValue:(NSString*)digit;

- (void) RegisterBinaryOperator:(NSString*)oper;

- (void) Reset;


- (void) StoreValue;
- (void) RecallValue;
- (void) ClearValue;


@end
