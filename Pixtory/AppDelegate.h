//
//  AppDelegate.h
//  Pixtory
//
//  Created by Andyy Hope on 1/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Locator.h"

@class ViewController;
@class MainViewController;
@class REMenu;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{

}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) MainViewController *mainViewController;
@property (strong, nonatomic) Locator *locationManager;

-(void)shareLinkWithFacebook:(NSString *)postString withImage:(UIImage *)postImage;
-(void)shareLinkWithTwitter:(NSString *)postString withImage:(UIImage *)postImage;
-(void)shareMomentWithFacebook:(NSDictionary *)moment andImage:(UIImage *)postImage;
-(void)shareMomentWithTwitter:(NSDictionary *)moment andImage:(UIImage *)postImage;

@end
