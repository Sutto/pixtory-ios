//
//  AppDelegate.m
//  Pixtory
//
//  Created by Andyy Hope on 1/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "MainViewController.h"
#import "SocialClass.h"
#import "REMenu.h"
#import "AFNetworkActivityIndicatorManager.h"
@implementation AppDelegate

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSArray *parts = [url.path componentsSeparatedByString:@"/"];
    if([url.host isEqualToString:@"moment"] && parts.count == 2) {
        NSString *identifier = [parts objectAtIndex:1];
        NSLog(@"Loading moment: %@", identifier);
        [self.mainViewController loadMomentFromId:identifier];
        return YES;
    }
    return NO;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.mainViewController = [[MainViewController alloc] initWithStyle:UITableViewStylePlain];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.mainViewController];
    
    
    self.locationManager = [Locator locator];
    [self.locationManager start];
    
    
    // navigation bar background image
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavigationBarBackground"] forBarMetrics:UIBarMetricsDefault];
    

    self.window.rootViewController = self.navController;
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)shareMomentWithFacebook:(NSDictionary *)moment andImage:(UIImage *)postImage {
    NSString *momentURL = [NSString stringWithFormat:@"http://ourpixtory.com/moment?moment=%@", [moment valueForKey:@"id"]];
    NSString *message = [NSString stringWithFormat:@"\"%@\" from Pixtory: %@", [moment valueForKey:@"caption"], momentURL];
    [self shareLinkWithFacebook:message withImage:postImage];
}

-(void)shareMomentWithTwitter:(NSDictionary *)moment andImage:(UIImage *)postImage {
    NSString *momentURL = [NSString stringWithFormat:@"http://ourpixtory.com/moment?moment=%@", [moment valueForKey:@"id"]];
    NSString *message = [NSString stringWithFormat:@"%@ - %@ (via @OurPixtory)", [moment valueForKey:@"caption"], momentURL];
    [self shareLinkWithTwitter:message withImage:postImage];
}

-(void)shareLinkWithFacebook:(NSString *)postString withImage:(UIImage *)postImage
{
    [SocialClass facebookSheetToView:self.navController withString:postString withImage:postImage];
}
-(void)shareLinkWithTwitter:(NSString *)postString withImage:(UIImage *)postImage
{
    [SocialClass twitterSheetToView:self.navController withString:postString withImage:postImage];
}
@end
