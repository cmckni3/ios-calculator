//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Chris on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL userAlreadyPressedDot;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize stackDisplay = _stackDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize userAlreadyPressedDot = _userAlreadyPressedDot;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setDisplay:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        self.display.text = [self.display.text stringByAppendingFormat:digit];
    }
    else
    {
        if (![digit isEqualToString:@"0"])
        {
            self.display.text = digit;
            self.userIsInTheMiddleOfEnteringANumber = YES;
        }
    }
}

- (IBAction)dotPressed:(UIButton *)sender
{
    if (!self.userAlreadyPressedDot)
    {
        [self digitPressed:sender];
        self.userAlreadyPressedDot = YES;
    }
}

- (IBAction)backspacePressed {
    NSUInteger len = [self.display.text length];
    NSString *lastDigit = [self.display.text substringFromIndex:len-1];
    if (len > 1)
        self.display.text = [self.display.text substringToIndex:len-1];
    else
    {
        self.display.text = @"0";
        self.userIsInTheMiddleOfEnteringANumber = NO;
    }
    if ([lastDigit isEqualToString:@"."])
        self.userAlreadyPressedDot = NO;
}

- (IBAction)operationPressed:(UIButton *)sender {
    NSString *operation = [sender currentTitle];
    if ([operation isEqualToString:@"+/-"] && self.userIsInTheMiddleOfEnteringANumber)
    {
        self.display.text = [NSString stringWithFormat:@"%g", -1*[self.display.text doubleValue]];
    }
    else
    {
        if (self.userIsInTheMiddleOfEnteringANumber)
            [self enterPressed];
        double result = [self.brain performOperation:operation];
        self.display.text = [NSString stringWithFormat:@"%g", result];
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userAlreadyPressedDot = NO;
}

- (IBAction)clearPressed {
    self.display.text = [NSString stringWithFormat:@"%d", 0];
    [self.brain clear];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userAlreadyPressedDot = NO;
}
@end
