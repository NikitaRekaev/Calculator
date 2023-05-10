//  CalculatorBuilder.m
//  Nikita Rekaev 05.05.2023

#import "CalculatorBuilder.h"
#import "CalculatorViewModel.h"
#import "CalculatorViewController.h"

@implementation CalculatorBuilder

+ (UIViewController *)build {
    CalculatorViewModel *viewModel = [[CalculatorViewModel alloc] init];
    CalculatorViewController *viewController = [[CalculatorViewController alloc] init];
    viewModel.view = viewController;
    viewController.output = viewModel;

    return viewController;
}

@end
