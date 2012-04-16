//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Chris McKnight on 4/9/12.
//  Copyright (c) 2012 Chris McKnight. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack
{
    if (!_programStack) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (void)setProgramStack:(NSMutableArray *)anArray
{
    // only getters and setters access _programStack (instance variable)
    _programStack = anArray;
}

- (void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

-(id)program
{
    // return immutable copy of programStack
    return [self.programStack copy];
}

- (double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program];
}

- (void)clear
{
    if ([self.programStack count])
        [self.programStack removeAllObjects];
    
}

+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]])
        stack = [program mutableCopy];
    return [self popOperandOffStack:stack];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    return @"Implement this in assignment 2";
}

+ (double)popOperandOffStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]])
        result = [topOfStack doubleValue];
    else
    if ([topOfStack isKindOfClass:[NSString class]])
    {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"])
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        else
        if ([@"-" isEqualToString:operation])
        {
            double subtractend = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subtractend;
        }
        else
        if ([operation isEqualToString:@"*"])
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack]; 
        else
        if ([operation isEqualToString:@"/"])
        {
            double divisor = [self popOperandOffStack:stack];
            if (divisor) result = [self popOperandOffStack:stack] / divisor;
        }
        else
        if ([operation isEqualToString:@"sin"])
            result = sin([self popOperandOffStack:stack]);
        else
        if ([operation isEqualToString:@"cos"])
            result = cos([self popOperandOffStack:stack]);
        else
        if ([operation isEqualToString:@"tan"])
            result = tan([self popOperandOffStack:stack]);
        else
        if ([operation isEqualToString:@"log"])
        {
            double operand = [self popOperandOffStack:stack];
            if (operand >= 0)
                result = log10(operand);
        }
        else
        if ([operation isEqualToString:@"sqrt"])
        {
            double operand = [self popOperandOffStack:stack];
            if (operand >= 0)
                result = sqrt(operand);
        }
        else
        if ([operation isEqualToString:@"π"])
            result = 4*atan(1.0);
        else
        if ([operation isEqualToString:@"e"])
        {
            double sum = 0;
            for (int i = 0; i < 13; i++)
            {
                int factorial = i;
                int factorialResult = 1;
                while (factorial != 0)
                {
                    factorialResult *= factorial;
                    factorial = factorial - 1;
                }
                sum += (double)1/factorialResult;
            }
            result = sum;
        }
        else
        if ([operation isEqualToString:@"+/-"])
        {
            double operand = [self popOperandOffStack:stack];
            if (operand)
                result = -1*operand;
        }
    }
    
    return result;
}

@end
