//  ViewModel.m
//  Nikita Rekaev 05.05.2023

#import "CalculatorViewModel.h"


#pragma mark - Constants

#define buttonTitles @[@"0", @",", @"=", @"1", @"2", @"3", @"+", @"4", @"5", @"6", @"−", @"7", @"8", @"9", @"×", @"AC", @"±", @"%", @"÷"]


#pragma mark - Interface

@interface CalculatorViewModel ()

@property (nonatomic, strong) NSString *outputString;
@property (nonatomic, assign) BOOL isNegative;
@property (nonatomic, strong) NSString *firstValue;
@property (nonatomic, strong) NSString *secondValue;
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
    if (_outputString.length >= 9 || ([value isEqualToString:@"."] && [_outputString containsString:@"."])) {
        return;
    }

    if ([_outputString isEqualToString:@"0"] && ![value isEqualToString:@"."]) {
        _outputString = value;
    } else {
        _outputString = [_outputString stringByAppendingString:value];
    }

    if (_operator == 0) {
        _firstValue = _outputString;
    } else {
        _secondValue = _outputString;
        _outputString = _secondValue;
    }

    [_view updateValue:_outputString];
}

- (void)operatorButtonPressed:(NSString *)value {
    if ([value  isEqual: @"+"]) {
        _operator = '+';
    } else if ([value  isEqual: @"−"]) {
        _operator = '-';
    } else if ([value  isEqual: @"×"]) {
        _operator = '*';
    } else if ([value  isEqual: @"÷"]) {
        _operator = '/';
    }

    _outputString = @"";
}

- (void)percentButtonPressed:(NSString *)value {
    _outputString = [NSString stringWithFormat:@"%.4g", [_outputString floatValue] * 0.01];
    [_view updateValue:_outputString];
}

- (void)negateButtonPressed:(NSString *)value {
    if ([_outputString isEqualToString:@"0"] || [_outputString isEqualToString:@""]) {
        return;
    }

    if (_isNegative) {
        _outputString = [_outputString substringFromIndex:1];
        _isNegative = NO;
    } else {
        _outputString = [@"−" stringByAppendingString:_outputString];
        _isNegative = YES;
    }

    [_view updateValue:_outputString];
}

- (void)clearButtonPressed:(NSString *)value {
    _isNegative = NO;
    _firstValue = nil;
    _secondValue = nil;
    _operator = 0;
    _outputString = @"0";
    [_view updateValue:_outputString];
}

- (void)resultButtonPressed:(NSString *)value {
    [self calculate];
    [_view updateValue:_outputString];
}


#pragma mark - Private methods

- (void)calculate {
    float value = 0.0;
    switch (_operator) {
        case '+':
            value = [_firstValue floatValue] + [_secondValue floatValue];
            break;
        case '-':
            value = [_firstValue floatValue] - [_secondValue floatValue];
            break;
        case '*':
            value = [_firstValue floatValue] * [_secondValue floatValue];
            break;
        case '/':
            value = [_firstValue floatValue] / [_secondValue floatValue];
            break;
        default:
            break;
    }
    
    _outputString = [NSString stringWithFormat:@"%.4g", value];;
    _firstValue = _outputString;
    _secondValue = nil;
    _operator = 0;
}

@end
