//  ViewModel.h
//  Nikita Rekaev 05.05.2023

#import "CalculatorViewInput.h"
#import "CalculatorViewOutput.h"

@interface CalculatorViewModel : NSObject <CalculatorViewOutput>

@property (nonatomic, weak) id<CalculatorViewInput> view;
@property (nonatomic, strong) NSArray *titles;

@end
