//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Chris on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    if (!_operandStack) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}

- (void)setOperandStack:(NSMutableArray *)anArray
{
    // only getters and setters access _operandStack (instance variable)
    _operandStack = anArray;
}

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)performOperation:(NSString *)operation
{
    double result = 0;
    if ([operation isEqualToString:@"+"])
         result = [self popOperand] + [self popOperand];
    else
    if ([@"-" isEqualToString:operation])
    {
        double subtractend = [self popOperand];
        result = [self popOperand] - subtractend;
    }
    else
    if ([operation isEqualToString:@"*"])
        result = [self popOperand] * [self popOperand]; 
    else
    if ([operation isEqualToString:@"/"])
    {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    }
    else
    if ([operation isEqualToString:@"sin"])
        result = sin([self popOperand]);
    else
    if ([operation isEqualToString:@"cos"])
        result = cos([self popOperand]);
    else
    if ([operation isEqualToString:@"tan"])
        result = tan([self popOperand]);
    else
    if ([operation isEqualToString:@"log"])
        result = log10([self popOperand]);
    else
    if ([operation isEqualToString:@"sqrt"])
        result = sqrt([self popOperand]);
    else
    if ([operation isEqualToString:@"π"])
        result = 4*atan(1.0);
    else
    if ([operation isEqualToString:@"e"])
        result = 2.71;
    else
    if ([operation isEqualToString:@"+/-"])
    {
        double operand = [self popOperand];
        if (operand)
            result = -1*operand;
    }
    [self pushOperand:result];
    return result;
}

- (void)clear
{
    if ([self.operandStack count])
        [self.operandStack removeAllObjects];
    
}

@end
