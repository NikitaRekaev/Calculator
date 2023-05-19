//  AppDelegate.m
//  Nikita Rekaev 28.04.2023

#import "AppDelegate.h"
#import "CalculatorBuilder.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureUserInterface];
    return YES;
}

- (void)configureUserInterface {
    CalculatorBuilder *builder = [[CalculatorBuilder alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [builder build];
    [self.window makeKeyAndVisible];
}

@end
