//
//  CalculatorBrain.h
//  Calculator
//
//  Created by SASIPA TANYARATSRISAKUL on 2/3/15.
//
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void) pushOperand:(double)operand;
- (double)performOperation:(NSString *) operation;
@end
