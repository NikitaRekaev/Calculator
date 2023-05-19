//  CalculatorViewOutput.h
//  Nikita Rekaev 09.05.2023

#import <Foundation/Foundation.h>

@protocol CalculatorViewOutput <NSObject>

@property (atomic, strong) NSArray *titles;

- (void)didLoadView;
- (void)numberButtonPressed:(NSString *)value;
- (void)operatorButtonPressed:(NSString *)value;
- (void)percentButtonPressed;
- (void)negateButtonPressed;
- (void)clearButtonPressed;
- (void)resultButtonPressed;

@end
