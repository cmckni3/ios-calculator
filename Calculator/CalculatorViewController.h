//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Chris on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *stackDisplay;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)dotPressed:(UIButton *)sender;
- (IBAction)backspacePressed;
- (IBAction)operationPressed:(UIButton *)sender;
- (IBAction)enterPressed;
- (IBAction)clearPressed;

@end
