//  CalculatorViewInput.h
//  Nikita Rekaev 09.05.2023

#import <Foundation/Foundation.h>

@protocol CalculatorViewInput <NSObject>

- (void)updateValue:(NSString *)value;

@end
