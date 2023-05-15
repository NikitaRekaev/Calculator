//  CalculatorTest.m
//  Nikita Rekaev 15.05.2023

#import <XCTest/XCTest.h>
#import "CalculatorViewModel.h"

@interface CalculatorViewModelTest : XCTestCase

@property (nonatomic, strong) CalculatorViewModel *viewModel;

@end

@implementation CalculatorViewModelTest

- (void)setUp {
    [super setUp];
    self.viewModel = [[CalculatorViewModel alloc] init];
    [self.viewModel didLoadView];
}

- (void)tearDown {
    self.viewModel = nil;
    [super tearDown];
}

- (void)testNumberButtonPressed {
    [self.viewModel numberButtonPressed:@"1"];

    XCTAssertEqualObjects(self.viewModel.outputString, @"1");
}

- (void)testOperatorButtonPressed {
    [self.viewModel operatorButtonPressed:@"+"];

    XCTAssertEqualObjects(self.viewModel.operator, @"+");
    XCTAssertEqualObjects(self.viewModel.outputString, @"");
}

- (void)testPercentButtonPressed {
    [self.viewModel numberButtonPressed:@"5"];
    [self.viewModel percentButtonPressed];

    XCTAssertEqualObjects(self.viewModel.outputString, @"0.05");
}

- (void)testFirstPressNegateButton {
    [self.viewModel numberButtonPressed:@"5"];
    [self.viewModel negateButtonPressed];

    XCTAssertEqualObjects(self.viewModel.outputString, @"-5");
}

- (void)testSecondPressNegateButton {
    [self.viewModel numberButtonPressed:@"5"];
    [self.viewModel negateButtonPressed];
    [self.viewModel negateButtonPressed];

    XCTAssertEqualObjects(self.viewModel.outputString, @"5");
}

- (void)testClearButtonPressed {
    [self.viewModel numberButtonPressed:@"5"];
    [self.viewModel clearButtonPressed];

    XCTAssertEqualObjects(self.viewModel.outputString, @"0");
    XCTAssertEqual(self.viewModel.firstValue, 0);
    XCTAssertEqual(self.viewModel.secondValue, 0);
    XCTAssertNil(self.viewModel.operator);
}

- (void)testResultButtonPressed {
    [self.viewModel numberButtonPressed:@"5"];
    [self.viewModel operatorButtonPressed:@"+"];
    [self.viewModel numberButtonPressed:@"2"];
    [self.viewModel resultButtonPressed];

    XCTAssertEqualObjects(self.viewModel.outputString, @"7");
    XCTAssertEqual(self.viewModel.firstValue, 7);
    XCTAssertEqual(self.viewModel.secondValue, 0);
    XCTAssertNil(self.viewModel.operator);
}

- (void)testDivideByZero {
    [self.viewModel numberButtonPressed:@"5"];
    [self.viewModel operatorButtonPressed:@"÷"];
    [self.viewModel numberButtonPressed:@"0"];
    [self.viewModel resultButtonPressed];

    XCTAssertEqualObjects(self.viewModel.outputString, @"Error");
    XCTAssertEqual(self.viewModel.firstValue, 0);
    XCTAssertEqual(self.viewModel.secondValue, 0);
    XCTAssertNil(self.viewModel.operator);
}

@end
