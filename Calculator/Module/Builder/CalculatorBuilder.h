//  CalculatorBuilder.h
//  Nikita Rekaev 05.05.2023

#import <UIKit/UIKit.h>

#import "CalculatorViewModel.h"
#import "CalculatorViewController.h"

@interface CalculatorBuilder : NSObject

- (UIViewController *)build;

@end
