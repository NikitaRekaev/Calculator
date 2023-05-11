//  ViewModel.m
//  Nikita Rekaev 05.05.2023

#import "CalculatorViewModel.h"


#pragma mark - Constants

#define buttonTitles @[@"0", @".", @"=", @"1", @"2", @"3", @"+", @"4", @"5", @"6", @"−", @"7", @"8", @"9", @"×", @"AC", @"±", @"%", @"÷"]
#define plusString buttonTitles[6]
#define minusString buttonTitles[10]
#define multiplyString buttonTitles[14]
#define divideString buttonTitles[18]
#define errorText @"Error"
#define formatString @"%.9g"
#define emptyString @""
#define dotString buttonTitles[1]
#define zeroString buttonTitles[0]
#define zeroNumber 0
#define maxLength 9


#pragma mark - Interface

@interface CalculatorViewModel ()

@property (nonatomic, strong) NSString *outputString;
@property (nonatomic) BOOL isNegative;
@property double firstValue;
@property double secondValue;
@property NSString* operator;

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
    _isNegative = NO;
}

- (void)numberButtonPressed:(NSString *)value {
    [self configureOutputString:value];
    [self updateValue:_outputString];
    [_view updateValue:_outputString];
}


- (void)operatorButtonPressed:(NSString *)value {
    _operator = value;
    _isNegative = NO;
    _outputString = emptyString;
}

- (void)percentButtonPressed:(NSString *)value {
    _outputString = [NSString stringWithFormat:formatString, [_outputString floatValue] * 0.01];
    [_view updateValue:_outputString];
}

- (void)negateButtonPressed:(NSString *)value {
    if ([_outputString isEqualToString:zeroString] || [_outputString isEqualToString:emptyString]) {
        return;
    }

    [self setIsNegative];
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
    if (_outputString.length >= maxLength || ([value isEqualToString:dotString] && [_outputString containsString:dotString])) {
        return;
    } else if ([_outputString isEqualToString:zeroString] && ![value isEqualToString:dotString]) {
        _outputString = value;
    } else {
        _outputString = [_outputString stringByAppendingString:value];
    }
}

- (void)updateValue:(NSString *)value {
    double selfValue = [value doubleValue];
    if (_operator == zeroNumber) {
        _firstValue = selfValue;
    } else {
        _secondValue = selfValue;
    }
}

- (void)setIsNegative {
    if (_isNegative) {
        _outputString = [_outputString substringFromIndex:1];
        _isNegative = NO;
    } else {
        _outputString = [minusString stringByAppendingString:_outputString];
        _isNegative = YES;
    }
}

- (double)calculate {
    if ([_operator isEqual: plusString]) {
        return _firstValue + _secondValue;
    } else if ([_operator isEqual: minusString]) {
        return _firstValue - _secondValue;
    } else if ([_operator isEqual: multiplyString]) {
        return _firstValue * _secondValue;
    } else if ([_operator isEqual: divideString]) {
            return _firstValue / _secondValue;
    }
    return NAN;
}

- (void)setResult:(double)value {
    if (isnan(value) || isinf(value)) {
        _outputString = errorText;
    } else {
        _outputString = [NSString stringWithFormat:formatString, value];
    }

    if (_isNegative) {
        _outputString = [minusString stringByAppendingString:_outputString];
    }

    _firstValue = value;
    _secondValue = zeroNumber;
    _operator = emptyString;
}

- (void)clear {
    _isNegative = NO;
    _firstValue = zeroNumber;
    _secondValue = zeroNumber;
    _operator = emptyString;
    _outputString = zeroString;
}

@end
