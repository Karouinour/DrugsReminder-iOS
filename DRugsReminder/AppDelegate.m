//
//  AppDelegate.m
//  DRugsReminder
//
//  Created by DrugsReminder on 25/02/2015.
//  Copyright (c) 2015 DrugsReminder. All rights reserved.
//

#import "AppDelegate.h"



#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

@interface AppDelegate ()

@end



@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIStoryboard *storyboard = nil;
    if(IS_IPAD)
    {
        NSLog(@"IS_IPAD");
        storyboard = [UIStoryboard storyboardWithName:@"IPad" bundle:[NSBundle mainBundle]];
        
    }
    if(IS_IPHONE)
    {
        NSLog(@"IS_IPHONE");
    }
    if(IS_RETINA)
    {
        NSLog(@"IS_RETINA");
    }
    if(IS_IPHONE_4_OR_LESS)
    {
        NSLog(@"IS_IPHONE_4_OR_LESS");
        storyboard = [UIStoryboard storyboardWithName:@"IPhone4-4s" bundle:[NSBundle mainBundle]];
        
    }
    if(IS_IPHONE_5)
    {
        NSLog(@"IS_IPHONE_5");
        storyboard = [UIStoryboard storyboardWithName:@"IPhone5-5s" bundle:[NSBundle mainBundle]];
        
    }
    if(IS_IPHONE_6)
    {
        NSLog(@"IS_IPHONE_6");
        storyboard = [UIStoryboard storyboardWithName:@"IPhone6" bundle:[NSBundle mainBundle]];
        
    }
    if(IS_IPHONE_6P)
    {
        NSLog(@"IS_IPHONE_6P");
        storyboard = [UIStoryboard storyboardWithName:@"IPhone6plus" bundle:[NSBundle mainBundle]];
    }
    
    
    
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]]; // this will change the back button tint
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0 green:0.588 blue:0.533 alpha:1]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    UIViewController *vc =[storyboard instantiateInitialViewController];
    
    // Set root view controller and make windows visible
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    self.eventManager = [[EventManager alloc] init];

    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
