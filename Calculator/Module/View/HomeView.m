//  HomeView.m
//  Nikita Rekaev 28.04.2023

#import "HomeView.h"

#pragma mark - Constants

#define buttonTitles @[@"0", @",", @"=", @"1", @"2", @"3", @"+", @"4", @"5", @"6", @"−", @"7", @"8", @"9", @"×", @"AC", @"±", @"%", @"÷"]
#define buttonFontSize 36
#define buttonStandartSize self.frame.size.width / 4.7
#define buttonSpacing  10
#define labelFontSize 72
#define labelPadding 30
#define labelBottom 20
#define labelHeight 60

#pragma mark - Interface

@interface HomeView (private)

@property (nonatomic, strong) UILabel *outputLabel;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSArray *titles;

@end

#pragma mark - Implementation

@implementation HomeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.titles = buttonTitles;
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor blackColor];
    [self configureButtons];
    [self configureOutputLabel];
}

#pragma mark - Actions

- (void)buttonTapped:(UIButton *)sender {

}

#pragma mark - Configure label

- (void)configureOutputLabel {
    self.outputLabel = [[UILabel alloc] init];
    self.outputLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.outputLabel.font = [UIFont systemFontOfSize: labelFontSize];
    self.outputLabel.textColor = [UIColor whiteColor];
    self.outputLabel.textAlignment = NSTextAlignmentRight;
    self.outputLabel.text = buttonTitles.firstObject;
    [self addSubview: self.outputLabel];
    UIButton *lastButton = [self.buttons lastObject];

    [NSLayoutConstraint activateConstraints:@[
        [self.outputLabel.bottomAnchor constraintEqualToAnchor: lastButton.topAnchor constant:-labelBottom],
        [self.outputLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:labelPadding],
        [self.outputLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-labelPadding],
        [self.outputLabel.heightAnchor constraintEqualToConstant:labelHeight]
    ]];
}

#pragma mark - Configure buttons

- (void)configureButtons {
    self.buttons = [NSMutableArray array];
    CGFloat x = buttonSpacing;
    CGFloat y = -labelPadding;

    for (NSString *title in self.titles) {
        UIButton *button = [self createButton:title];
        [self setConstraintForButton:button x:&x y:&y];
    }
}

- (UIButton *)createButton:(NSString *)title {
    UIButton *button = [UIButton buttonWithType: UIButtonTypeSystem];
    [button setTitle: title forState: UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize: buttonFontSize];
    button.layer.cornerRadius = buttonStandartSize / 2;
    [button addTarget: self action: @selector(buttonTapped:) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview:button];
    [self.buttons addObject:button];
    [self setColorForButton: button];
    return button;
}

- (void)setColorForButton:(UIButton *)button {
    [button setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    NSString *title = button.currentTitle;
    if ([title isEqualToString:@"+"] ||
        [title isEqualToString:@"−"] ||
        [title isEqualToString:@"×"] ||
        [title isEqualToString:@"÷"] ||
        [title isEqualToString:@"="]) {
        button.backgroundColor = [UIColor orangeColor];
    } else if ([title isEqualToString:@"AC"] ||
               [title isEqualToString:@"±"] ||
               [title isEqualToString:@"%"]) {
        button.backgroundColor = [UIColor lightGrayColor];
        [button setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    } else {
        button.backgroundColor = [UIColor darkGrayColor];
    }
}

- (void)setConstraintForButton:(UIButton *)button x:(CGFloat *)x y:(CGFloat *)y {
    CGFloat buttonHeight = buttonStandartSize;
    CGFloat buttonWidth = buttonStandartSize;
    CGFloat spacing = buttonSpacing;

    button.translatesAutoresizingMaskIntoConstraints = NO;

    if ([button.currentTitle isEqualToString:@"0"]) {
        buttonWidth = (buttonWidth * 2) + spacing;
    }

    [NSLayoutConstraint activateConstraints:@[
        [button.widthAnchor constraintEqualToConstant: buttonWidth],
        [button.heightAnchor constraintEqualToConstant: buttonHeight],
        [button.bottomAnchor constraintEqualToAnchor: self.bottomAnchor constant: *y],
        [button.leftAnchor constraintEqualToAnchor: self.leftAnchor constant: *x],
    ]];

    *x += buttonWidth + spacing;
    if (*x > self.bounds.size.width - buttonHeight - spacing) {
        *x = spacing;
        *y -= buttonWidth + spacing;
    }
}

@end
