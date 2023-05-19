//  CalculatorButton.m
//  Nikita Rekaev 10.05.2023

#import "CalculatorButton.h"


#pragma mark - Constants

#define FONT_SIZE ([UIScreen mainScreen].bounds.size.width / 11.5)
#define RECT_FOR_SQUARE (CGRectMake(0.0f, 0.0f, 100.0f, 100.0f))
#define RECT_FOR_RECTANGULAR (CGRectMake(0.0f, 0.0f, 100.0f, 50.0f))

static NSString *const zeroString = @"0";
static NSString *const plus = @"+";
static NSString *const minus = @"−";
static NSString *const multiply = @"×";
static NSString *const divide = @"÷";
static NSString *const clear = @"AC";
static NSString *const negate = @"±";
static NSString *const percent = @"%";
static NSString *const result = @"=";

#pragma mark - Interface

@interface CalculatorButton ()

@property (atomic, assign) NSString *title;

@end


@implementation CalculatorButton

#pragma mark - Init

- (instancetype)initWithTitle:(NSString *)title {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.title = title;
        self.type = [self setType];
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
    self.titleLabel.font = [UIFont systemFontOfSize:FONT_SIZE];
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
    CGRect rect = [_title  isEqual: zeroString] ? RECT_FOR_RECTANGULAR : RECT_FOR_SQUARE;
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
