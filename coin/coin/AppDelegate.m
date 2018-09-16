//
//  AppDelegate.m
//  coin
//
//  Created by Richard Dawson on 11/7/16.
//  Copyright © 2016 Richard Dawson. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <RFKeyboardToolbar.h>
#import <IQKeyboardManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    // Initialize Parse to the Heroku server
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"taylorscoin";
        configuration.server = @"http://taylorscoin.herokuapp.com/parse";
    }]];
    
    
    //Change the Navigation appearance
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor],
      NSForegroundColorAttributeName,
      [UIColor whiteColor],
      NSForegroundColorAttributeName,
      nil]];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    //Change the Tab Bar appearance
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0]];
    [[UITabBar appearance] setTranslucent:NO];
    [[UITabBar appearance] setUnselectedItemTintColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0]];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    //Check if there is a current user
    PFUser *currentUser = [PFUser currentUser];
    
    //Create instance of the main storyboard
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    //If there is a current user with session token
    if (currentUser) {
        
        //Get the main tab controller
        UIViewController *mainViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"mainTab"];
        
        //Go to the main tab controller
        self.window.rootViewController = mainViewController;
    }
    //If there isn't a current user
    else {
        
        //Get the Log in screen
        UIViewController *loginViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"mainLogin"];
        
        //Go to the login screen
        self.window.rootViewController = loginViewController;
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
