//  CalculatorViewController.m
//  Nikita Rekaev 28.04.2023

#import "CalculatorViewController.h"


#pragma mark - Constants

#define screenWidth self.view.bounds.size.width
#define buttonSideLength screenWidth / 5
#define buttonSpacing screenWidth / 25
#define labelPadding buttonSpacing * 1.5
#define labelBottom buttonSpacing / 1.75
#define labelMinFontSize buttonSideLength / 2
#define labelFontSizeDelta screenWidth / 84
#define lengthForMaxFontSize 6


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
    [self setNeedFontSizeForLabel:value];
    _outputLabel.text = value;
}


#pragma mark - Actions

- (void)buttonPressed:(CalculatorButton *)sender {
    switch (sender.type) {
        case CalculatorButtonTypeNumber:
            [_output numberButtonPressed:sender.currentTitle];
            break;
        case CalculatorButtonTypeOperation:
            [self highlightButton:sender];
            [_output operatorButtonPressed:sender.currentTitle];
            break;
        case CalculatorButtonTypePercent:
            [_output percentButtonPressed:sender.currentTitle];
            break;
        case CalculatorButtonTypeNegate:
            [_output negateButtonPressed:sender.currentTitle];
            break;
        case CalculatorButtonTypeClear:
            [self highlightButton:sender];
            [_output clearButtonPressed:sender.currentTitle];
            break;
        case CalculatorButtonTypeResult:
            [self highlightButton:sender];
            [_output resultButtonPressed:sender.currentTitle];
            break;
    }
}


#pragma mark - Configure label

- (void)configureOutputLabel {
    _outputLabel = [[UILabel alloc] init];
    _outputLabel.font = [UIFont systemFontOfSize: buttonSideLength];
    _outputLabel.textColor = [UIColor whiteColor];
    _outputLabel.textAlignment = NSTextAlignmentRight;
    [self setConstraintForOutputLabel];
}

- (void)setConstraintForOutputLabel {
    [self.view addSubview: self.outputLabel];
    _outputLabel.translatesAutoresizingMaskIntoConstraints = NO;
    UIButton *lastButton = [self.buttons lastObject];

    [NSLayoutConstraint activateConstraints:@[
        [_outputLabel.bottomAnchor constraintEqualToAnchor: lastButton.topAnchor constant:-labelBottom],
        [_outputLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:labelPadding],
        [_outputLabel.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-labelPadding],
        [_outputLabel.heightAnchor constraintEqualToConstant:buttonSideLength]
    ]];
}


#pragma mark - Configure buttons

- (void)configureButtons {
    CGFloat x = buttonSpacing;
    CGFloat y = -buttonSpacing;

    for (NSString *title in _output.titles) {
        UIButton *button = [self createButton:title];
        [self setConstraintForButton:button x:&x y:&y];
    }
}

- (UIButton *)createButton:(NSString *)title {
    CalculatorButton *button = [[CalculatorButton alloc] initWithTitle:title];
    [button addTarget: self action: @selector(buttonPressed:) forControlEvents: UIControlEventTouchUpInside];
    [_buttons addObject:button];
    return button;
}

- (void)setConstraintForButton:(UIButton *)button x:(CGFloat *)x y:(CGFloat *)y {
    [self.view addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;

    CGFloat buttonWidth = buttonSideLength;

    if ([button.currentTitle isEqualToString:@"0"]) {
        buttonWidth = (buttonWidth * 2) + buttonSpacing;
    }

    [NSLayoutConstraint activateConstraints:@[
        [button.widthAnchor constraintEqualToConstant: buttonWidth],
        [button.heightAnchor constraintEqualToConstant: buttonSideLength],
        [button.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor constant: *y],
        [button.leftAnchor constraintEqualToAnchor: self.view.leftAnchor constant: *x],
    ]];

    *x += buttonWidth + buttonSpacing;

    if (*x > screenWidth - buttonSideLength - buttonSpacing) {
        *x = buttonSpacing;
        *y -= buttonWidth + buttonSpacing;
    }
}


#pragma mark - Private methods

- (void)setNeedFontSizeForLabel:(NSString *)value {
    CGFloat fontSize = buttonSideLength - (((CGFloat)[value length] - lengthForMaxFontSize) * labelFontSizeDelta);
    fontSize = fmaxf(fontSize, labelMinFontSize);
    _outputLabel.font = [UIFont systemFontOfSize:fontSize];
}

- (void)highlightButton:(CalculatorButton *)sender {
    for (CalculatorButton *button in _buttons) {
        [button setSelected:false];
    }
    [sender setSelected:true];
}

@end
