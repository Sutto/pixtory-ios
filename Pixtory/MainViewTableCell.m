//
//  MainViewTableCell.m
//  Pixtory
//
//  Created by Andyy Hope on 1/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//

#import "MainViewTableCell.h"
#import "Appearance.h"
#import "AppDelegate.h"
#import "SocialClass.h"

@implementation MainViewTableCell
{
    UIImageView *pictureViewBacking;
    BOOL menuShowing;
    UIImageView *closeButtonImage;
    UIImageView *moreButtonImage;
    UIView *menuView;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.streetLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 290, 200, 30)];
        self.yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 310, 200, 30)];
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
        
        self.streetLabel.font = kHEADER_FONT;
        self.streetLabel.textColor = kHEADER_FONT_COLOR;
        self.streetLabel.backgroundColor = [UIColor clearColor];
        self.yearLabel.font = kTEXT_FONT;
        self.yearLabel.textColor = kTEXT_FONT_COLOR;
        self.yearLabel.backgroundColor = self.streetLabel.backgroundColor;
        
        self.pictureView.layer.cornerRadius = 3;
        
        UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(self.pictureView.frame.origin.x,
                                                                    self.pictureView.frame.origin.y + self.pictureView.frame.size.height - 20,
                                                                    self.pictureView.frame.size.width,
                                                                     50)];
        coverView.backgroundColor = [UIColor whiteColor];
        
        UIView *dropShadow = [[UIView alloc] initWithFrame:CGRectMake(11, 11, 300, coverView.frame.origin.y + coverView.frame.size.height - 10)];
        dropShadow.backgroundColor = [UIColor blackColor];
        dropShadow.alpha = 0.1;
        [self.contentView addSubview:dropShadow];
        
        
        pictureViewBacking = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PictureBacking"]];
        pictureViewBacking.frame = self.pictureView.frame;
        
        [self.contentView addSubview:pictureViewBacking];
        [self.contentView addSubview:self.pictureView];
        [self.contentView addSubview:coverView];
        
        [self.contentView addSubview:self.streetLabel];
        [self.contentView addSubview:self.yearLabel];
        
        
        UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        moreButton.frame = CGRectMake(coverView.frame.size.width - 50, 0, 50, 50);
        
        [moreButton addTarget:self action:@selector(moreButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        //moreButton.backgroundColor = [UIColor redColor];
        [coverView addSubview:moreButton];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:@"NearbyListScrolling" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            [self hideOverlay];
        }];
        
        closeButtonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CloseIcon"]];
        closeButtonImage.frame = CGRectMake(coverView.frame.size.width - 35, 15, 20, 20);
        closeButtonImage.alpha = 0;
        [coverView addSubview:closeButtonImage];
        
        moreButtonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ShareIcon"]];
        moreButtonImage.frame = CGRectMake(coverView.frame.size.width - 35, 15, 20, 20);
        [coverView addSubview:moreButtonImage];
        
        
        [self createMenuView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)createMenuView
{
    menuView = [[UIView alloc] initWithFrame:CGRectMake(self.pictureView.frame.origin.x,
                                                        self.pictureView.frame.origin.y,
                                                        self.pictureView.frame.size.width,
                                                        self.pictureView.frame.size.height - 20)];
    [self.contentView addSubview:menuView];
    menuView.alpha = 0.0f;
    UILabel *shareWithLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (menuView.frame.size.height / 2) - 70, menuView.frame.size.width, 30)];
    
    shareWithLabel.text = @"Show my friends";
    shareWithLabel.textColor = [UIColor whiteColor];
    shareWithLabel.font = kSUB_MENU_FONT;
    shareWithLabel.textAlignment = NSTextAlignmentCenter;
    shareWithLabel.backgroundColor = [UIColor clearColor];
    
    UIButton *hideMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hideMenuButton.frame = menuView.frame;
    [hideMenuButton addTarget:self action:@selector(moreButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [menuView addSubview:hideMenuButton];
    
    UIButton *facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [facebookButton setImage:[UIImage imageNamed:@"FacebookIcon"] forState:UIControlStateNormal];
    facebookButton.frame = CGRectMake((menuView.frame.size.width / 2) - 64 - 12, menuView.frame.size.height / 2 - 32, 64, 64);
    [facebookButton addTarget:self action:@selector(shareWithFacebook) forControlEvents:UIControlEventTouchUpInside];
    [menuView addSubview:facebookButton];
    
    UIButton *twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [twitterButton setImage:[UIImage imageNamed:@"TwitterIcon"] forState:UIControlStateNormal];
    twitterButton.frame = CGRectMake((menuView.frame.size.width / 2) + 12, menuView.frame.size.height / 2 - 32, 64, 64);
    [twitterButton addTarget:self action:@selector(shareWithTwitter) forControlEvents:UIControlEventTouchUpInside];
    [menuView addSubview:twitterButton];
    
    
    [menuView addSubview:shareWithLabel];
}
- (void)moreButtonPressed
{

    if (!menuShowing)
    {   // show menu
        [UIView animateWithDuration:0.3 animations:^{
            menuView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.85f];
            menuView.alpha = 1.0f;
            moreButtonImage.alpha = 0.0f;
            closeButtonImage.alpha = 1.0f;
        }];
        menuShowing = true;
        NSLog(@"Show");
    } else
    {   // hide menu
        [self hideOverlay];
    }
    
}

-(void)hideOverlay
{
    if(!menuShowing) return;
    [UIView animateWithDuration:0.3 animations:^{
        menuView.alpha = 0.0f;
        moreButtonImage.alpha = 1.0f;
        closeButtonImage.alpha = 0.0f;
    }];
    menuShowing = false;
    
    NSLog(@"Hide");
}

-(void)shareWithFacebook
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate shareMomentWithFacebook:self.moment andImage:self.pictureView.image];
}

-(void)shareWithTwitter
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate shareMomentWithTwitter:self.moment andImage:self.pictureView.image];
}
@end
