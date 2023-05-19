//  CalculatorBuilder.m
//  Nikita Rekaev 05.05.2023

#import "CalculatorBuilder.h"

@implementation CalculatorBuilder

- (UIViewController *)build {
    CalculatorPresenter *presenter = [[CalculatorPresenter alloc] init];
    CalculatorViewController *viewController = [[CalculatorViewController alloc] init];
    
    presenter.view = viewController;
    viewController.output = presenter;

    return viewController;
}

@end
