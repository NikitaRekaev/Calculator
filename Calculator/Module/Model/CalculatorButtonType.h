//  CalculatorButtonType.h
//  Nikita Rekaev 10.05.2023

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CalculatorButtonType) {
    CalculatorButtonTypeNumber,
    CalculatorButtonTypeOperation,
    CalculatorButtonTypeResult,
    CalculatorButtonTypeClear,
    CalculatorButtonTypeNegate,
    CalculatorButtonTypePercent
};
