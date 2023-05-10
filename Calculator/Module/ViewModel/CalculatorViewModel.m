//  ViewModel.m
//  Nikita Rekaev 05.05.2023

#import "CalculatorViewModel.h"


#pragma mark - Constants

#define buttonTitles @[@"0", @",", @"=", @"1", @"2", @"3", @"+", @"4", @"5", @"6", @"−", @"7", @"8", @"9", @"×", @"AC", @"±", @"%", @"÷"]


#pragma mark - Interface

@interface CalculatorViewModel ()

@property (nonatomic, strong) NSString *outputString;
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
}

- (void)numberButtonPressed:(NSString *)value {
    if (_outputString.length >= 6) {
        return;
    }

    _outputString = [_outputString  isEqual: @"0"] ? _outputString = value : [_outputString stringByAppendingString:value];

    if (!_operator) {
        _firstValue = _outputString;
    }
    
    [_view updateValue:_outputString];
}

- (void)operatorButtonPressed:(NSString *)value {
    if ([value isEqualToString:@"="]) {
        [self calculate];
        [_view updateValue:_outputString];
    }
    _operator = *strdup([value UTF8String]);
}

- (void)percentButtonPressed:(NSString *)value {
    _outputString = [NSString stringWithFormat:@"%f", [_outputString floatValue] * 0.01];
    [_view updateValue:_outputString];
}

- (void)negateButtonPressed:(NSString *)value {
    _outputString = [@"−" stringByAppendingString:_outputString];
    [_view updateValue:_outputString];
}

- (void)clearButtonPressed:(NSString *)value {
    _outputString = @"0";
    [_view updateValue:_outputString];
}


#pragma mark - Private methods

- (void)calculate {
    switch (_operator) {
        case '+':
            _secondValue = _outputString;
            _outputString = [NSString stringWithFormat:@"%f.1",[_firstValue floatValue] + [_secondValue floatValue]];
            _outputString = [_outputString substringWithRange:NSMakeRange(0, [_outputString rangeOfString:@"."].location + 2)];
        default:
            break;
    }
    _operator = !_operator;
    [_view updateValue:_outputString];
}

@end
