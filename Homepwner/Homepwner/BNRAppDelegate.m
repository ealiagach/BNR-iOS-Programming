//
//  BNRAppDelegate.m
//  Homepwner
//
//  Created by Enrique Aliaga on 11/7/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

#import "BNRAppDelegate.h"
#import "BNRItemsViewController.h"
#import "BNRItemStore.h"

NSString * const BNRNextItemValuePrefsKey = @"NextItemValue";
NSString * const BNRNextItemNamePrefsKey = @"NextItemName";

@implementation BNRAppDelegate


+ (void)initialize
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *factorySettings = @{ BNRNextItemValuePrefsKey: @75,
                                       BNRNextItemNamePrefsKey: @"Coffee Cup" };
    [defaults registerDefaults:factorySettings];
}


- (BOOL)application:(UIApplication *)application
    willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    return YES;
}


- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // If state restoration did not occur,
    // set up the view controller hierarchy
    if (!self.window.rootViewController) {
        // Create a BNRItemsViewController
        BNRItemsViewController *itemsViewController = [[BNRItemsViewController alloc] init];
        
        // Create an instance of a UINavigationController
        // its stack contains only itemsViewController
        UINavigationController *navController = [[UINavigationController alloc]
            initWithRootViewController:itemsViewController];
        
        // Give the navigation controller a restoration identifier that is
        // the same name as the class
        navController.restorationIdentifier = NSStringFromClass([navController class]);
        
        // Place navigation controller's view in the window hierarchy
        self.window.rootViewController = navController;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for
     certain types of temporary interruptions (such as an incoming phone call or SMS message) or
     when the user quits the application and it begins the transition to the background state.
     
     Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering
     callbacks. Games should use this method to pause the game.
     */
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    BOOL success = [[BNRItemStore sharedStore] saveChanges];
    if (success) {
        NSLog(@"Saved all of the BNRItems");
    } else {
        NSLog(@"Could not save any of the BNRItems");
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the active state; here you can undo
     many of the changes made on entering the background.
     */
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     If the application was previously in the background, optionally refresh the user interface.
     */
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate. Save data if appropriate. See also
     applicationDidEnterBackground:.
     */
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


#pragma mark - State restoration

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    return YES;
}


- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    return YES;
}


- (UIViewController *)application:(UIApplication *)application
    viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)path coder:(NSCoder *)coder
{
    // Create a new navigation controller
    UIViewController *vc = [[UINavigationController alloc] init];
    
    // The last object in the path array is the restoration
    // identifier for this view controller
    vc.restorationIdentifier = [path lastObject];
    
    // If there is only 1 identifier component, then
    // this is the root view controller
    if ([path count] == 1) {
        self.window.rootViewController = vc;
    }
    
    return vc;
}


@end
