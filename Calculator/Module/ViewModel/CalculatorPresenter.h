//  CalculatorPresenter.h
//  Nikita Rekaev 05.05.2023

#import "CalculatorViewInput.h"
#import "CalculatorViewOutput.h"

@interface CalculatorPresenter : NSObject <CalculatorViewOutput>

@property (atomic, weak) id<CalculatorViewInput> view;
@property (atomic, strong) NSArray *titles;

@property (atomic, strong) NSString *outputString;
@property (atomic, strong) NSString *operator;
@property (atomic) double firstValue;
@property (atomic) double secondValue;

@end
