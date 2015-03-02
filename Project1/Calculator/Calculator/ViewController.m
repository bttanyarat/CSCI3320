//
//  ViewController.m
//  Calculator
//
//  Created by BANDIT TANYARATSRISAKUL on 2/2/15.
//
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
// use to check if the number is floating point number
@property (nonatomic) BOOL numberIsDecimal;
@property (nonatomic, strong) CalculatorBrain *brain;

@end

@implementation ViewController

@synthesize display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize numberIsDecimal;
@synthesize brain = _brain;
@synthesize brainDisplay;

- (CalculatorBrain *)brain {
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}
- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    // do nothing if user pressed more than one "."
    if ([digit isEqualToString:@"."] && numberIsDecimal){ }
    else if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else if ([digit isEqualToString:@"."] && !numberIsDecimal){
        self.display.text = [self.display.text stringByAppendingString:digit];
        self.userIsInTheMiddleOfEnteringANumber = YES;
        self.numberIsDecimal = YES;
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}
- (IBAction)enterPressed {
    self.brainDisplay.text = [self.brainDisplay.text stringByAppendingString:[self.display.text stringByAppendingString:@" "]];
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.numberIsDecimal = NO;
}
- (IBAction)operationPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    self.brainDisplay.text = [self.brainDisplay.text stringByAppendingString:[sender currentTitle]];
    self.brainDisplay.text = [self.brainDisplay.text stringByAppendingString:@" = "];
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}
// method for C button
- (IBAction)c:(UIButton *)sender {
    self.display.text = @"0";
    self.brainDisplay.text = @"";
    [self.brain clear];
}
// method for backspace button
- (IBAction)backspace:(UIButton *)sender {
    if([self.display.text length] > 1){
        self.display.text = [self.display.text substringToIndex:[self.display.text length] - 1];
    } else {
        self.display.text = @"0";
        self.userIsInTheMiddleOfEnteringANumber = NO;
    }
}
// method for +/- button
- (IBAction)plusMinus:(UIButton *)sender {
    if (!self.userIsInTheMiddleOfEnteringANumber){
        [self operationPressed:sender];
    } else if ([self.display.text hasPrefix:@"-"]){
        self.display.text = [self.display.text substringFromIndex:1];
    } else {
        self.display.text = [@"-" stringByAppendingString:[self.display.text self]];
    }
}
// method for undo button
- (IBAction)undo:(UIButton *)sender {
    // act like backspace button until all numbers gone
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self backspace:sender];
    } else {
        [self.brain popOperand];
    }
}
@end
