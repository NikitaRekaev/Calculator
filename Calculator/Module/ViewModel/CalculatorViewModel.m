//  ViewModel.m
//  Nikita Rekaev 05.05.2023

#import "CalculatorViewModel.h"


#pragma mark - Constants

#define buttonTitles @[@"0", @",", @"=", @"1", @"2", @"3", @"+", @"4", @"5", @"6", @"−", @"7", @"8", @"9", @"×", @"AC", @"±", @"%", @"÷"]
#define format @"%.9g"


#pragma mark - Interface

@interface CalculatorViewModel ()

@property (nonatomic, strong) NSString *outputString;
@property (nonatomic) BOOL isNegative;
@property double firstValue;
@property double secondValue;
@property char operator;

@end


@implementation CalculatorViewModel

#pragma mark - Init

- (instancetype)init {
    self.titles = buttonTitles;
    return self;
}

#pragma mark - View Output

- (void)didLoadView {
    _outputString = @"0";
    _isNegative = NO;
}

- (void)numberButtonPressed:(NSString *)value {
    if (_outputString.length >= 9 || ([value isEqualToString:@","] && [_outputString containsString:@","])) {
        return;
    }

    if ([_outputString isEqualToString:@"0"] && ![value isEqualToString:@","]) {
        _outputString = value;
    } else {
        _outputString = [_outputString stringByAppendingString:value];
    }

    [self addValue:_outputString];
    [_view updateValue:_outputString];
}


- (void)operatorButtonPressed:(NSString *)value {
    [self addOperator:value];
    _isNegative = NO;
    _outputString = @"";
}

- (void)percentButtonPressed:(NSString *)value {
    _outputString = [NSString stringWithFormat:format, [_outputString floatValue] * 0.01];
    [_view updateValue:_outputString];
}

- (void)negateButtonPressed:(NSString *)value {
    if ([_outputString isEqualToString:@"0"] || [_outputString isEqualToString:@""]) {
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

- (void)addValue:(NSString *)value {
    double selfValue = [value doubleValue];
    if (_operator == 0) {
        _firstValue = selfValue;
    } else {
        _secondValue = selfValue;
    }
}

- (void)addOperator:(NSString *)value {
    if ([value  isEqual: @"+"]) {
        _operator = '+';
    } else if ([value  isEqual: @"−"]) {
        _operator = '-';
    } else if ([value  isEqual: @"×"]) {
        _operator = '*';
    } else if ([value  isEqual: @"÷"]) {
        _operator = '/';
    }
}

- (void)setIsNegative {
    if (_isNegative) {
        _outputString = [_outputString substringFromIndex:1];
        _isNegative = NO;
    } else {
        _outputString = [@"−" stringByAppendingString:_outputString];
        _isNegative = YES;
    }
}

- (double)calculate {
    double value = 0.0;
    switch (_operator) {
        case '+':
            value = _firstValue + _secondValue;
            break;
        case '-':
            value = _firstValue - _secondValue;
            break;
        case '*':
            value = _firstValue * _secondValue;
            break;
        case '/':
            if (_secondValue == 0.0) {
                value = NAN;
            } else {
                value = _firstValue / _secondValue;
            }
            break;
        default:
            break;
    }

    return value;
}

- (void)setResult:(double)value {
    if (isnan(value) || isinf(value)) {
        _outputString = @"Error";
    } else {
        _outputString = [NSString stringWithFormat:format, value];
    }

    if (_isNegative) {
        _outputString = [@"−" stringByAppendingString:_outputString];
    }

    _firstValue = value;
    _secondValue = 0;
    _operator = 0;
}

- (void)clear {
    _isNegative = NO;
    _firstValue = 0;
    _secondValue = 0;
    _operator = 0;
    _outputString = @"0";
}

@end
