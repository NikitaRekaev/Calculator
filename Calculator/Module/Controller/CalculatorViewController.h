//  CalculatorViewController.h
//  Nikita Rekaev 28.04.2023

#import <UIKit/UIKit.h>
#import "CalculatorViewModel.h"

@interface CalculatorViewController : UIViewController

- (instancetype)initWithViewModel:(CalculatorViewModel *)viewModel;

@end

