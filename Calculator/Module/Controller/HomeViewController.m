//  HomeViewController.m
//  Nikita Rekaev 28.04.2023

#import "HomeViewController.h"
#import "HomeView.h"

@interface HomeViewController ()

@end


@implementation HomeViewController

- (void)loadView {
    [super loadView];
    UIView *newView = [[HomeView alloc] initWithFrame: self.view.bounds];
    self.view = newView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

@end
