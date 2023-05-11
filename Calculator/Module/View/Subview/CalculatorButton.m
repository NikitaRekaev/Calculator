//  CalculatorButton.m
//  Nikita Rekaev 10.05.2023

#import "CalculatorButton.h"


#pragma mark - Constants

#define fontSize 36
#define rectForSquare CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)
#define rectForRectangular CGRectMake(0.0f, 0.0f, 100.0f, 50.0f)
#define zeroString @"0"
#define plus @"+"
#define minus @"−"
#define multiply @"×"
#define divide @"÷"
#define clear @"AC"
#define negate @"±"
#define percent @"%"
#define result @"="


@implementation CalculatorButton

#pragma mark - Init

- (instancetype)initWithTitle:(NSString *)title {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _title = title;
        _type = [self setType];
        [self setAppearance];
    }
    return self;
}

#pragma mark - Public methods

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (_type == CalculatorButtonTypeOperation) {
        [self setTitleColor:selected ? UIColor.orangeColor : UIColor.whiteColor forState:UIControlStateNormal];
        [self setBackgroundColor:selected ? [UIColor whiteColor] : [UIColor orangeColor] forState:UIControlStateNormal];
    }
}


#pragma mark - Private methods

- (CalculatorButtonType)setType {
    if ([_title isEqualToString:plus] ||
        [_title isEqualToString:minus] ||
        [_title isEqualToString:multiply] ||
        [_title isEqualToString:divide]) {
        return CalculatorButtonTypeOperation;
    } else if ([_title isEqualToString:clear]) {
        return CalculatorButtonTypeClear;
    } else if ([_title isEqualToString:negate]) {
        return CalculatorButtonTypeNegate;
    } else if ([_title isEqualToString:percent]) {
        return CalculatorButtonTypePercent;
    } else if ([_title isEqualToString:result]) {
        return CalculatorButtonTypeResult;
    } else {
        return CalculatorButtonTypeNumber;
    }
}

- (void)setAppearance {
    [self setTitle: _title forState: UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self setColor];
}

- (void)setColor {
    switch (_type) {
        case CalculatorButtonTypeResult:
        case CalculatorButtonTypeOperation:
            [self setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
            [self setBackgroundColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [self setBackgroundColor:[UIColor systemOrangeColor] forState:UIControlStateHighlighted];
            break;
        case CalculatorButtonTypeNumber:
            [self setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
            [self setBackgroundColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [self setBackgroundColor:[UIColor systemGrayColor] forState:UIControlStateHighlighted];
            break;
        default:
            [self setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
            [self setBackgroundColor:[UIColor systemGrayColor] forState:UIControlStateNormal];
            [self setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            break;
    }
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    CGRect rect = [_title  isEqual: zeroString] ? rectForRectangular : rectForSquare;
    CGFloat cornerRadius = rect.size.height / 2.0f;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();

    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    [roundedRect addClip];

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self setBackgroundImage:colorImage forState:state];
}

@end
