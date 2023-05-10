//  CalculatorButton.h
//  Nikita Rekaev 10.05.2023

#import <UIKit/UIKit.h>
#import "CalculatorButtonType.h"

@interface CalculatorButton : UIButton

@property (nonatomic, assign) CalculatorButtonType type;
@property (nonatomic, assign) NSString* title;
@property (nonatomic, assign) BOOL isSelected;

- (instancetype)initWithTitle: (NSString*)title;

@end
