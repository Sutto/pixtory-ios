//
//  SocialClass.m
//  Pixtory
//
//  Created by Andyy Hope on 1/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//


#import "SocialClass.h"

@implementation SocialClass


+ (void)facebookSheetToView:(UINavigationController *)navController withString:(NSString *)postString withImage:(UIImage *)postImage
{
    SLComposeViewController *facebookViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [facebookViewController setInitialText:postString];
    
    [facebookViewController addImage:postImage];
    
    [navController presentViewController:facebookViewController animated:YES completion:nil];
    
}
+ (void)twitterSheetToView:(UINavigationController *)navController withString:(NSString *)postString withImage:(UIImage *)postImage
{
    SLComposeViewController *twitterViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    [twitterViewController setInitialText:postString];
    
    [twitterViewController addImage:postImage];
    
    [navController presentViewController:twitterViewController animated:YES completion:nil];

}
@end
