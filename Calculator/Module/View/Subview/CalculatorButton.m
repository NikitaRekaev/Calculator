//  CalculatorButton.m
//  Nikita Rekaev 10.05.2023

#import "CalculatorButton.h"


#pragma mark - Constants

#define buttonFontSize 36


@implementation CalculatorButton

#pragma mark - Init

- (instancetype)initWithTitle: (NSString *)title {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _title = title;
        _type = [self setType];
        [self setViewAppearance];
    }
    return self;
}

#pragma mark - Public methods

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (self.type == CalculatorButtonTypeOperation) {
        [self setTitleColor:selected ? UIColor.orangeColor : UIColor.whiteColor forState:UIControlStateNormal];
        self.backgroundColor = selected ? [UIColor whiteColor] : [UIColor orangeColor];
    }
}


#pragma mark - Private methods

- (CalculatorButtonType)setType {
    if ([_title isEqualToString:@"+"] ||
        [_title isEqualToString:@"−"] ||
        [_title isEqualToString:@"×"] ||
        [_title isEqualToString:@"÷"]) {
        return CalculatorButtonTypeOperation;
    } else if ([_title isEqualToString:@"AC"]) {
        return CalculatorButtonTypeClear;
    } else if ([_title isEqualToString:@"±"]) {
        return CalculatorButtonTypeNegate;
    } else if ([_title isEqualToString:@"%"]) {
        return CalculatorButtonTypePercent;
    } else if ([_title isEqualToString:@"="]) {
        return CalculatorButtonTypeResult;
    } else {
        return CalculatorButtonTypeNumber;
    }
}

- (void)setViewAppearance {
    [self setTitle: _title forState: UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:buttonFontSize];
    [self setColor];
}

- (void)setColor {
    switch (_type) {
        case CalculatorButtonTypeResult:
        case CalculatorButtonTypeOperation:
            [self setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
            self.backgroundColor = [UIColor orangeColor];
            break;
        case CalculatorButtonTypeNumber:
            [self setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
            [self setTitleColor:[UIColor lightGrayColor] forState: UIControlStateHighlighted];
            self.backgroundColor = [UIColor darkGrayColor];
            break;
        default:
            [self setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
            [self setTitleColor:[UIColor darkGrayColor] forState: UIControlStateHighlighted];
            self.backgroundColor = [UIColor lightGrayColor];
            break;
    }
}


@end
