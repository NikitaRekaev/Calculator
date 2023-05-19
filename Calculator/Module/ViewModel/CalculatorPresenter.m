//  CalculatorPresenter.m
//  Nikita Rekaev 05.05.2023

#import "CalculatorPresenter.h"


#pragma mark - Constants

#define TITLES @[@"0", @".", @"=", @"1", @"2", @"3", @"+", @"4", @"5", @"6", @"−", @"7", @"8", @"9", @"×", @"AC", @"±", @"%", @"÷"]

static NSString *const zeroString = @"0";
static NSString *const negativeZeroString = @"-0";
static NSString *const dotString = @".";
static NSString *const plusTitle = @"+";
static NSString *const minusTitle = @"−";
static NSString *const multiplyTitle = @"×";
static NSString *const divideTitle = @"÷";
static NSString *const minusString = @"-";
static NSString *const errorText = @"Error";
static NSString *const outputFormat = @"%.9g";
static NSString *const emptyString = @"";
static NSString *const zeroWithDot = @"0.";
static unichar const minusChar = '-';
static NSUInteger const maxLength = 9;
static unichar const tooLongIndicator = 'e';


@implementation CalculatorPresenter

#pragma mark - Init

- (instancetype)init {
    self.titles = TITLES;
    return self;
}


#pragma mark - View Output

- (void)didLoadView {
    self.outputString = zeroString;
    [_view updateValue:_outputString];
}

- (void)numberButtonPressed:(NSString *)value {
    [self configureOutputString:value];
    [self updateValue:_outputString];
    [_view updateValue:_outputString];
}

- (void)operatorButtonPressed:(NSString *)value {
    self.operator = value;
    self.outputString = emptyString;
}

- (void)percentButtonPressed {
    [self calculatePercent];
    [_view updateValue:_outputString];
}

- (void)negateButtonPressed {
    [self makeValueNegative];
    [self updateValue:_outputString];
    [_view updateValue:_outputString];
}

- (void)clearButtonPressed {
    [self clear];
    [_view updateValue:_outputString];
}

- (void)resultButtonPressed {
    double calculatedValue = [self calculate];
    [self setResult:calculatedValue];
    [_view updateValue:_outputString];
}


#pragma mark - Private methods

- (void)configureOutputString:(NSString *)value {
    if ([self isCorrectValue:value]) {
        return;
    } else if ([value  isEqual:dotString] && [_outputString  isEqual:errorText]) {
        self.outputString = zeroWithDot;
    } else if ([self isStartValue:value]) {
        self.outputString = value;
    } else {
        self.outputString = [_outputString stringByAppendingString:value];
    }
}

- (BOOL)isCorrectValue:(NSString *)value {
    return (_outputString.length >= maxLength ||
    ([value isEqualToString:dotString] && [_outputString containsString:dotString]));
}

- (BOOL)isStartValue:(NSString *)value {
    BOOL isTooLong = NO;

    for (NSUInteger i = 0; i < _outputString.length; i++) {
        unichar character = [_outputString characterAtIndex:i];
        if (character == tooLongIndicator) {
            isTooLong = YES;
        }
    }

    return (([_outputString isEqualToString:zeroString] && ![value isEqualToString:dotString]) ||
            [_outputString isEqualToString:errorText] ||
            isTooLong);
}

- (void)updateValue:(NSString *)value {
    double doubleValue = [value doubleValue];
    if (_operator == 0) {
        self.firstValue = doubleValue;
    } else {
        self.secondValue = doubleValue;
    }
}

- (void)calculatePercent {
    self.outputString = [NSString stringWithFormat:outputFormat, [_outputString doubleValue] * 0.01];
    if ([_outputString isEqualToString:negativeZeroString] || [_outputString isEqualToString:zeroString]) {
        [self clear];
    }
}

- (void)makeValueNegative {
    if ([_outputString isEqualToString:zeroString] || [_outputString isEqualToString:emptyString]) {
        return;
    } else if ([_outputString characterAtIndex:0] == minusChar) {
        self.outputString = [_outputString substringFromIndex:1];
    } else {
        self.outputString = [minusString stringByAppendingString:_outputString];
    }
}

- (double)calculate {
    if ([_operator isEqual: plusTitle]) {
        return _firstValue + _secondValue;
    } else if ([_operator isEqual: minusTitle]) {
        return _firstValue - _secondValue;
    } else if ([_operator isEqual: multiplyTitle]) {
        return _firstValue * _secondValue;
    } else if ([_operator isEqual: divideTitle]) {
        return _firstValue / _secondValue;
    }
    return NAN;
}

- (void)setResult:(double)value {
    [self clear];
    [self configureOutputAfterCalculate:value];
}

- (void)configureOutputAfterCalculate:(double)value {
    if (isnan(value) || isinf(value)) {
        self.outputString = errorText;
        self.firstValue = 0;
    } else {
        self.outputString = [NSString stringWithFormat:outputFormat, value];
        self.firstValue = value;
    }
}

- (void)clear {
    self.firstValue = 0;
    self.secondValue = 0;
    self.operator = NULL;
    self.outputString = zeroString;
}

@end
