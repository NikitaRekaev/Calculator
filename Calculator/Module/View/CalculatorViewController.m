//  CalculatorViewController.m
//  Nikita Rekaev 28.04.2023

#import "CalculatorViewController.h"


#pragma mark - Constants

#define SCREEN_WIDTH (self.view.bounds.size.width)
#define BUTTON_SIDE_LENGTH (SCREEN_WIDTH / 5)
#define BUTTON_SPACING (SCREEN_WIDTH / 25)
#define LABEL_PADDING (BUTTON_SPACING * 1.5)
#define LABEL_BOTTOM (BUTTON_SPACING / 1.75)
#define LABEL_MIN_FONT_SIZE (BUTTON_SIDE_LENGTH / 2.1)
#define LABEL_FONT_SIZE_DELTA (SCREEN_WIDTH / 84)

static NSUInteger const lengthForMaxFontSize = 5;


#pragma mark - Interface

@interface CalculatorViewController ()

@property (atomic, strong) UILabel *outputLabel;
@property (atomic, strong) NSMutableArray<CalculatorButton *> *buttons;

@end


@implementation CalculatorViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.buttons = [NSMutableArray array];
    [self configureButtons];
    [self configureOutputLabel];
    [_output didLoadView];
}


#pragma mark - View input

- (void)updateValue:(NSString *)value {
    [self setNeedFontSizeForLabel:value];
    self.outputLabel.text = value;
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
            [_output percentButtonPressed];
            break;
        case CalculatorButtonTypeNegate:
            [_output negateButtonPressed];
            break;
        case CalculatorButtonTypeClear:
            [self highlightButton:sender];
            [_output clearButtonPressed];
            break;
        case CalculatorButtonTypeResult:
            [self highlightButton:sender];
            [_output resultButtonPressed];
            break;
    }
}


#pragma mark - Configure label

- (void)configureOutputLabel {
    self.outputLabel = [[UILabel alloc] init];
    self.outputLabel.textColor = [UIColor whiteColor];
    self.outputLabel.textAlignment = NSTextAlignmentRight;
    [self setConstraintForOutputLabel];
}

- (void)setConstraintForOutputLabel {
    [self.view addSubview: self.outputLabel];
    self.outputLabel.translatesAutoresizingMaskIntoConstraints = NO;
    UIButton *lastButton = [self.buttons lastObject];

    [NSLayoutConstraint activateConstraints:@[
        [_outputLabel.bottomAnchor constraintEqualToAnchor: lastButton.topAnchor constant:-LABEL_BOTTOM],
        [_outputLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:LABEL_PADDING],
        [_outputLabel.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-LABEL_PADDING],
        [_outputLabel.heightAnchor constraintEqualToConstant:BUTTON_SIDE_LENGTH]
    ]];
}


#pragma mark - Configure buttons

- (void)configureButtons {
    CGFloat x = BUTTON_SPACING;
    CGFloat y = -BUTTON_SPACING;

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

    CGFloat buttonWidth = BUTTON_SIDE_LENGTH;

    if ([button.currentTitle isEqualToString:@"0"]) {
        buttonWidth = (buttonWidth * 2) + BUTTON_SPACING;
    }

    [NSLayoutConstraint activateConstraints:@[
        [button.widthAnchor constraintEqualToConstant: buttonWidth],
        [button.heightAnchor constraintEqualToConstant: BUTTON_SIDE_LENGTH],
        [button.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor constant: *y],
        [button.leftAnchor constraintEqualToAnchor: self.view.leftAnchor constant: *x],
    ]];

    *x += buttonWidth + BUTTON_SPACING;

    if (*x > SCREEN_WIDTH - BUTTON_SIDE_LENGTH - BUTTON_SPACING) {
        *x = BUTTON_SPACING;
        *y -= buttonWidth + BUTTON_SPACING;
    }
}


#pragma mark - Private methods

- (void)setNeedFontSizeForLabel:(NSString *)value {
    CGFloat fontSize = BUTTON_SIDE_LENGTH - (((CGFloat)[value length] - lengthForMaxFontSize) * LABEL_FONT_SIZE_DELTA);
    fontSize = fmaxf(fontSize, LABEL_MIN_FONT_SIZE);
    self.outputLabel.font = [UIFont systemFontOfSize:fontSize];
}

- (void)highlightButton:(CalculatorButton *)sender {
    for (CalculatorButton *button in _buttons) {
        [button setSelected:false];
    }
    [sender setSelected:true];
}

@end
