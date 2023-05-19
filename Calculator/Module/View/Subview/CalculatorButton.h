//  CalculatorButton.h
//  Nikita Rekaev 10.05.2023

#import <UIKit/UIKit.h>
#import "CalculatorButtonType.h"

@interface CalculatorButton : UIButton

@property (atomic, assign) CalculatorButtonType type;

- (instancetype)initWithTitle: (NSString *)title;

@end
