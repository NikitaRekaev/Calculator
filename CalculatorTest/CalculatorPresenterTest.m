//  CalculatorPresenterTest.m
//  Nikita Rekaev 15.05.2023

#import <XCTest/XCTest.h>
#import "CalculatorPresenter.h"

@interface CalculatorPresenterTest : XCTestCase

@property (nonatomic, strong) CalculatorPresenter *presenter;

@end

@implementation CalculatorPresenterTest

- (void)setUp {
    [super setUp];
    self.presenter = [[CalculatorPresenter alloc] init];
    [self.presenter didLoadView];
}

- (void)tearDown {
    self.presenter = nil;
    [super tearDown];
}

- (void)testNumberButtonPressed {
    [self.presenter numberButtonPressed:@"1"];

    XCTAssertEqualObjects(self.presenter.outputString, @"1");
}

- (void)testOperatorButtonPressed {
    [self.presenter operatorButtonPressed:@"+"];

    XCTAssertEqualObjects(self.presenter.operator, @"+");
    XCTAssertEqualObjects(self.presenter.outputString, @"");
}

- (void)testPercentButtonPressed {
    [self.presenter numberButtonPressed:@"5"];
    [self.presenter percentButtonPressed];

    XCTAssertEqualObjects(self.presenter.outputString, @"0.05");
}

- (void)testFirstPressNegateButton {
    [self.presenter numberButtonPressed:@"5"];
    [self.presenter negateButtonPressed];

    XCTAssertEqualObjects(self.presenter.outputString, @"-5");
}

- (void)testSecondPressNegateButton {
    [self.presenter numberButtonPressed:@"5"];
    [self.presenter negateButtonPressed];
    [self.presenter negateButtonPressed];

    XCTAssertEqualObjects(self.presenter.outputString, @"5");
}

- (void)testClearButtonPressed {
    [self.presenter numberButtonPressed:@"5"];
    [self.presenter clearButtonPressed];

    XCTAssertEqualObjects(self.presenter.outputString, @"0");
    XCTAssertEqual(self.presenter.firstValue, 0);
    XCTAssertEqual(self.presenter.secondValue, 0);
    XCTAssertNil(self.presenter.operator);
}

- (void)testResultButtonPressed {
    [self.presenter numberButtonPressed:@"5"];
    [self.presenter operatorButtonPressed:@"+"];
    [self.presenter numberButtonPressed:@"2"];
    [self.presenter resultButtonPressed];

    XCTAssertEqualObjects(self.presenter.outputString, @"7");
    XCTAssertEqual(self.presenter.firstValue, 7);
    XCTAssertEqual(self.presenter.secondValue, 0);
    XCTAssertNil(self.presenter.operator);
}

- (void)testDivideByZero {
    [self.presenter numberButtonPressed:@"5"];
    [self.presenter operatorButtonPressed:@"÷"];
    [self.presenter numberButtonPressed:@"0"];
    [self.presenter resultButtonPressed];

    XCTAssertEqualObjects(self.presenter.outputString, @"Error");
    XCTAssertEqual(self.presenter.firstValue, 0);
    XCTAssertEqual(self.presenter.secondValue, 0);
    XCTAssertNil(self.presenter.operator);
}

@end
