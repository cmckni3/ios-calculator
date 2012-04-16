//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Chris McKnight on 4/9/12.
//  Copyright (c) 2012 Chris McKnight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)clear;

@property (readonly) id program;

+ (double)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;

@end
