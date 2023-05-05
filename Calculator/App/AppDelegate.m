//  AppDelegate.m
//  Nikita Rekaev 28.04.2023

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureUserInterface];
    return YES;
}

- (void)configureUserInterface {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];
}

@end
