//  CalculatorViewModel.m
//  Nikita Rekaev 05.05.2023

#import "CalculatorViewModel.h"


#pragma mark - Constants

#define buttonTitles @[@"0", @".", @"=", @"1", @"2", @"3", @"+", @"4", @"5", @"6", @"−", @"7", @"8", @"9", @"×", @"AC", @"±", @"%", @"÷"]
#define plusTitle buttonTitles[6]
#define minusTitle buttonTitles[10]
#define multiplyTitle buttonTitles[14]
#define divideTitle buttonTitles[18]
#define errorText @"Error"
#define formatString @"%.9g"
#define emptyString @""
#define minusString @"-"
#define minusChar '-'
#define dotString buttonTitles[1]
#define zeroString buttonTitles[0]
#define zeroNumber 0
#define maxLength 9


#pragma mark - Interface

@interface CalculatorViewModel ()

@property (nonatomic, strong) NSString *outputString;
@property (nonatomic, strong) NSString* operator;
@property double firstValue;
@property double secondValue;

@end


@implementation CalculatorViewModel

#pragma mark - Init

- (instancetype)init {
    self.titles = buttonTitles;
    return self;
}


#pragma mark - View Output

- (void)didLoadView {
    _outputString = zeroString;
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

- (void)percentButtonPressed:(NSString *)value {
    _outputString = [NSString stringWithFormat:formatString, [_outputString floatValue] * 0.01];
    [_view updateValue:_outputString];
}

- (void)negateButtonPressed:(NSString *)value {
    [self setNegative];
    [self updateValue:_outputString];
    [_view updateValue:_outputString];
}

- (void)clearButtonPressed:(NSString *)value {
    [self clear];
    [_view updateValue:_outputString];
}

- (void)resultButtonPressed:(NSString *)value {
    double calculatedValue = [self calculate];
    [self setResult:calculatedValue];
    [_view updateValue:_outputString];
}


#pragma mark - Private methods

- (void)configureOutputString:(NSString *)value {
    if ([self isCorrectValue:value]) {
        return;
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
    return (([_outputString isEqualToString:zeroString] && ![value isEqualToString:dotString]) ||
            [_outputString isEqualToString:errorText]);
}

- (void)updateValue:(NSString *)value {
    double selfValue = [value doubleValue];
    if (_operator == zeroNumber) {
        _firstValue = selfValue;
    } else {
        _secondValue = selfValue;
    }
}

- (void)setNegative {
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
    [self configureOutputAfterCalculate:value];
    _firstValue = value;
    _secondValue = zeroNumber;
    _operator = emptyString;
}

- (void)configureOutputAfterCalculate:(double)value {
    if (isnan(value) || isinf(value)) {
        _outputString = errorText;
    } else {
        _outputString = [NSString stringWithFormat:formatString, value];
    }
}

- (void)clear {
    _firstValue = zeroNumber;
    _secondValue = zeroNumber;
    _operator = emptyString;
    _outputString = zeroString;
}

@end
