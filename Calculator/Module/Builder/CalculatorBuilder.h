//  CalculatorBuilder.h
//  Nikita Rekaev 05.05.2023

#import <UIKit/UIKit.h>

#import "CalculatorPresenter.h"
#import "CalculatorViewController.h"

@interface CalculatorBuilder : NSObject

- (UIViewController *)build;

@end
