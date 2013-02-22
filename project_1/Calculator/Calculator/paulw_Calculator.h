//
//  paulw_Calculator.h
//  Calculator
//
//  Created by Paul Weatherby on 2/19/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface paulw_Calculator : NSObject

@property (nonatomic) NSDouble currentValue;

@property (nonatomic) NSDouble storedValue;

- (NSDouble) Add:(NSDouble)d;
- (NSDouble) Subtract:(NSDouble)d;
- (NSDouble) Multiply:(NSDouble)d;
- (NSDouble) Divide:(NSDouble)d;

- (void) Reset;

- (void) StoreValue: (NSDouble)d;
- (NSDouble) RecallValue;
- (void) ClearValue;


@end
