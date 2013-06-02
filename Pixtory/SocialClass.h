//
//  SocialClass.h
//  Pixtory
//
//  Created by Andyy Hope on 1/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//
#import <Social/Social.h>
#import <Foundation/Foundation.h>

@interface SocialClass : NSObject
+ (void)facebookSheetToView:(UINavigationController *)navController withString:(NSString *)postString withImage:(UIImage *)postImage;
+ (void)twitterSheetToView:(UINavigationController *)navController withString:(NSString *)postString withImage:(UIImage *)postImage;
@end
