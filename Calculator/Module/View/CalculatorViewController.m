//  CalculatorViewController.m
//  Nikita Rekaev 28.04.2023

#import "CalculatorViewController.h"


#pragma mark - Constants

#define buttonStandartSize self.view.frame.size.width / 4.7
#define buttonSpacing  10
#define labelFontSize 72
#define labelPadding 30
#define labelBottom 20
#define labelHeight 60


#pragma mark - Interface

@interface CalculatorViewController ()

@property (nonatomic, strong) UILabel *outputLabel;
@property (nonatomic, strong) NSMutableArray<CalculatorButton *> *buttons;

@end


@implementation CalculatorViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    _buttons = [NSMutableArray array];
    self.view.backgroundColor = [UIColor blackColor];
    [self configureButtons];
    [self configureOutputLabel];
    [_output didLoadView];
}

#pragma mark - View input

- (void)updateValue:(NSString *)value {
    _outputLabel.text = value;
}


#pragma mark - Actions

- (void)buttonPressed:(CalculatorButton *)sender {
    switch (sender.type) {
        case CalculatorButtonTypeNumber:
            [_output numberButtonPressed:sender.currentTitle];
            break;
        case CalculatorButtonTypeOperation:
            [_output operatorButtonPressed:sender.currentTitle];
            break;
        case CalculatorButtonTypePercent:
            [_output percentButtonPressed:sender.currentTitle];
            break;
        case CalculatorButtonTypeNegate:
            [_output negateButtonPressed:sender.currentTitle];
            break;
        case CalculatorButtonTypeClear:
            [_output clearButtonPressed:sender.currentTitle];
            break;
    }
}


#pragma mark - Configure label

- (void)configureOutputLabel {
    self.outputLabel = [[UILabel alloc] init];
    self.outputLabel.font = [UIFont systemFontOfSize: labelFontSize];
    self.outputLabel.textColor = [UIColor whiteColor];
    self.outputLabel.textAlignment = NSTextAlignmentRight;
    self.outputLabel.text = _output.titles.firstObject;
    [self setConstraintForOutputLabel];
}

- (void)setConstraintForOutputLabel {
    [self.view addSubview: self.outputLabel];
    self.outputLabel.translatesAutoresizingMaskIntoConstraints = NO;
    UIButton *lastButton = [self.buttons lastObject];

    [NSLayoutConstraint activateConstraints:@[
        [self.outputLabel.bottomAnchor constraintEqualToAnchor: lastButton.topAnchor constant:-labelBottom],
        [self.outputLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:labelPadding],
        [self.outputLabel.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-labelPadding],
        [self.outputLabel.heightAnchor constraintEqualToConstant:labelHeight]
    ]];
}


#pragma mark - Configure buttons

- (void)configureButtons {
    CGFloat x = buttonSpacing;
    CGFloat y = -labelPadding;

    for (NSString *title in _output.titles) {
        UIButton *button = [self createButton:title];
        [self setConstraintForButton:button x:&x y:&y];
    }
}

- (UIButton *)createButton:(NSString *)title {
    CalculatorButton *button = [[CalculatorButton alloc] initWithTitle:title];
    [button addTarget: self action: @selector(buttonPressed:) forControlEvents: UIControlEventTouchUpInside];
    button.layer.cornerRadius = buttonStandartSize / 2;
    [self.buttons addObject:button];
    return button;
}

- (void)setConstraintForButton:(UIButton *)button x:(CGFloat *)x y:(CGFloat *)y {
    CGFloat buttonHeight = buttonStandartSize;
    CGFloat buttonWidth = buttonStandartSize;
    CGFloat spacing = buttonSpacing;

    [self.view addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;

    if ([button.currentTitle isEqualToString:@"0"]) {
        buttonWidth = (buttonWidth * 2) + spacing;
    }

    [NSLayoutConstraint activateConstraints:@[
        [button.widthAnchor constraintEqualToConstant: buttonWidth],
        [button.heightAnchor constraintEqualToConstant: buttonHeight],
        [button.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor constant: *y],
        [button.leftAnchor constraintEqualToAnchor: self.view.leftAnchor constant: *x],
    ]];

    *x += buttonWidth + spacing;

    if (*x > self.view.bounds.size.width - buttonHeight - spacing) {
        *x = spacing;
        *y -= buttonWidth + spacing;
    }
}


@end
