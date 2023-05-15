//  CalculatorViewModel.m
//  Nikita Rekaev 05.05.2023

#import "CalculatorViewModel.h"


#pragma mark - Constants

#define buttonTitles @[@"0", @".", @"=", @"1", @"2", @"3", @"+", @"4", @"5", @"6", @"−", @"7", @"8", @"9", @"×", @"AC", @"±", @"%", @"÷"]
#define zeroString buttonTitles[0]
#define dotString buttonTitles[1]
#define plusTitle buttonTitles[6]
#define minusTitle buttonTitles[10]
#define multiplyTitle buttonTitles[14]
#define divideTitle buttonTitles[18]
#define negativeZeroString [minusString stringByAppendingString:zeroString]
#define errorText @"Error"
#define outputFormat @"%.9g"
#define emptyString @""
#define minusString @"-"
#define zeroWithDot @"0."
#define minusChar '-'
#define zeroNumber 0
#define maxLength 9
#define tooLongIndicator 'e'


@implementation CalculatorViewModel

#pragma mark - Init

- (instancetype)init {
    self.titles = buttonTitles;
    return self;
}


#pragma mark - View Output

- (void)didLoadView {
    _outputString = zeroString;
    [_view updateValue:_outputString];
}

- (void)numberButtonPressed:(NSString *)value {
    [self configureOutputString:value];
    [self updateValue:_outputString];
    [_view updateValue:_outputString];
}

- (void)operatorButtonPressed:(NSString *)value {
    _operator = value;
    _outputString = emptyString;
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
        _outputString = zeroWithDot;
    } else if ([self isStartValue:value]) {
        _outputString = value;
    } else {
        _outputString = [_outputString stringByAppendingString:value];
    }
}

- (BOOL)isCorrectValue:(NSString *)value {
    return (_outputString.length >= maxLength ||
    ([value isEqualToString:dotString] && [_outputString containsString:dotString]));
}

- (BOOL)isStartValue:(NSString *)value {
    BOOL isTooLong = NO;

    for (NSUInteger i = zeroNumber; i < _outputString.length; i++) {
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
    if (_operator == zeroNumber) {
        _firstValue = doubleValue;
    } else {
        _secondValue = doubleValue;
    }
}

- (void)calculatePercent {
    _outputString = [NSString stringWithFormat:outputFormat, [_outputString doubleValue] * 0.01];
    if ([_outputString isEqualToString:negativeZeroString] || [_outputString isEqualToString:zeroString]) {
        [self clear];
    }
}

- (void)makeValueNegative {
    if ([_outputString isEqualToString:zeroString] || [_outputString isEqualToString:emptyString]) {
        return;
    } else if ([_outputString characterAtIndex:zeroNumber] == minusChar) {
        _outputString = [_outputString substringFromIndex:1];
    } else {
        _outputString = [minusString stringByAppendingString:_outputString];
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
        _outputString = errorText;
        _firstValue = zeroNumber;
    } else {
        _outputString = [NSString stringWithFormat:outputFormat, value];
        _firstValue = value;
    }
}

- (void)clear {
    _firstValue = zeroNumber;
    _secondValue = zeroNumber;
    _operator = NULL;
    _outputString = zeroString;
}

@end
