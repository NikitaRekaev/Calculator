//  CalculatorViewOutput.h
//  Nikita Rekaev 09.05.2023

#import <Foundation/Foundation.h>

@protocol CalculatorViewOutput <NSObject>

@property (nonatomic, strong) NSArray *titles;

- (void)didLoadView;
- (void)numberButtonPressed:(NSString *)value;
- (void)operatorButtonPressed:(NSString *)value;
- (void)percentButtonPressed:(NSString *)value;
- (void)negateButtonPressed:(NSString *)value;
- (void)clearButtonPressed:(NSString *)value;

@end
