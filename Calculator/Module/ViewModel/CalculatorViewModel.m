//  ViewModel.m
//  Nikita Rekaev 05.05.2023

#import "CalculatorViewModel.h"


#pragma mark - Constants

#define buttonTitles @[@"0", @",", @"=", @"1", @"2", @"3", @"+", @"4", @"5", @"6", @"−", @"7", @"8", @"9", @"×", @"AC", @"±", @"%", @"÷"]


@implementation CalculatorViewModel

#pragma mark - Init

- (instancetype)init {
    self.titles = buttonTitles;
    return self;
}

@end
