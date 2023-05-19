//  CalculatorViewController.h
//  Nikita Rekaev 28.04.2023

#import <UIKit/UIKit.h>

#import "CalculatorViewOutput.h"
#import "CalculatorViewInput.h"
#import "CalculatorButton.h"

@interface CalculatorViewController : UIViewController <CalculatorViewInput>

@property (atomic, strong) id<CalculatorViewOutput> output;

- (void)updateValue:(NSString *)value;

@end

