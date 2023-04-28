//  HomeView.m
//  Nikita Rekaev 28.04.2023

#import "HomeView.h"

@interface HomeView (private)

@property (nonatomic, strong) UILabel *outputLabel;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSArray *titles;

@end


@implementation HomeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.titles = @[@"0", @",", @"=", @"1", @"2", @"3", @"+", @"4", @"5", @"6", @"−", @"7", @"8", @"9", @"×", @"AC", @"±", @"%", @"÷"];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor blackColor];
    [self configureButtons];
    [self configureOutputLabel];
}

- (void)configureOutputLabel {
    self.outputLabel = [[UILabel alloc] init];
    self.outputLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.outputLabel.font = [UIFont systemFontOfSize: 72];
    self.outputLabel.textColor = [UIColor whiteColor];
    self.outputLabel.textAlignment = NSTextAlignmentRight;
    self.outputLabel.text = @"0";
    [self addSubview: self.outputLabel];
    UIButton *lastButton = [self.buttons lastObject];

    [NSLayoutConstraint activateConstraints:@[
        [self.outputLabel.bottomAnchor constraintEqualToAnchor: lastButton.topAnchor constant:-20],
        [self.outputLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:30],
        [self.outputLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-30],
        [self.outputLabel.heightAnchor constraintEqualToConstant:60]
    ]];
}

- (void)configureButtons {
    self.buttons = [NSMutableArray array];
    CGFloat x = 10;
    CGFloat y = -30;

    for (NSString *title in self.titles) {
        [self createButton:title];
    }

    for (UIButton *button in self.buttons) {
        [self setConstraintForButton:button x:&x y:&y];
    }
}

- (void)buttonTapped:(UIButton *)sender {
    
}

- (void)createButton:(NSString *)title {
    UIButton *button = [UIButton buttonWithType: UIButtonTypeSystem];
    [button setTitle: title forState: UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize: 36];
    button.layer.cornerRadius = self.frame.size.width / 9.4;
    [button addTarget: self action: @selector(buttonTapped:) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview:button];
    [self.buttons addObject:button];
    [self setColorForButton: button];
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
    CGFloat buttonHeight = self.frame.size.width / 4.7;
    CGFloat buttonWidth = self.frame.size.width / 4.7;
    CGFloat spacing = 10;

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
