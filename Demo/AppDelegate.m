//
//  AppDelegate.m
//  Demo
//
//  Created by Yuki on 2020/6/19.
//  Copyright © 2020 Zl. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
    self.window.rootViewController = nav;
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
