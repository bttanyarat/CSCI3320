//
//  CalculatorBrain.h
//  Calculator
//
//  Created by BANDIT TANYARATSRISAKUL on 2/3/15.
//
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void) pushOperand:(double)operand;
- (double)performOperation:(NSString *) operation;
// Method for C button, clearing operandStack
- (void)clear;
- (double) popOperand;
@end
