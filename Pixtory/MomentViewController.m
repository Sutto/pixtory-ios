//
//  MomentViewController.m
//  Pixtory
//
//  Created by Darcy Laycock on 1/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//
#import "AppDelegate.h"
#import "MomentViewController.h"
#import "AFNetworking/UIImageView+AFNetworking.h"
#import "Appearance.h"
#import <QuartzCore/QuartzCore.h>

#import "UILabel+AutoSize.h"
#import "UIBarButtonItem+FlatUI.h"

#import "MapsViewController.h"

@interface MomentViewController () <UIScrollViewDelegate>
{
    CGPoint pictureViewCoords;
    UIView *dropShadow;
    UIButton *twitterButton;
    UIButton *facebookButton;
    UIButton *mapsButton;
    UIButton *hideMenuButton;
    UIBarButtonItem *moreBarButtonItem;
    UIScrollView *scrollView;
    CGSize newSize;
    BOOL menuShowing;
}
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, strong) UIView        *menuOverlay;
@property (nonatomic, strong) UIView      *coverView;
@property (nonatomic, strong) UIImageView *pictureView;
@property (nonatomic, strong) UIImageView *pictureBacking;
@property (nonatomic, strong) UILabel     *locationLabel;
@property (nonatomic, strong) UILabel     *yearLabel;
@property (nonatomic, strong) UILabel     *captionLabel;
@property (nonatomic, strong) UILabel       *descriptionlabel;
@property (nonatomic, strong) UILabel       *copyrightLabel;
@property (nonatomic, strong) UIButton      *copyrightButton;


-(void)configureSubviews;

-(void)repositionItems;

@end

@implementation MomentViewController

-(void)configureSubviews {
    self.menuOverlay    = [[UIView alloc] init];
    self.locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 290, 280, 30)];
    self.yearLabel     = [[UILabel alloc] initWithFrame:CGRectMake(20, 310, 280, 30)];
    self.captionLabel  = [[UILabel alloc] initWithFrame:CGRectMake(20, 340, 280, 80)];
    self.pictureView   = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
    self.copyrightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.descriptionlabel = [UILabel new];
    self.copyrightLabel = [UILabel new];
    self.pictureBacking = [[UIImageView alloc] initWithFrame:self.pictureView.frame];
    self.pictureBacking.image = [UIImage imageNamed:@"PictureBacking"];
    
    self.locationLabel.font = kHEADER_FONT;
    self.locationLabel.textColor = kHEADER_FONT_COLOR;
    self.locationLabel.backgroundColor = [UIColor clearColor];
    self.yearLabel.font = kTEXT_FONT;
    self.yearLabel.textColor = kTEXT_FONT_COLOR;
    self.yearLabel.backgroundColor = self.locationLabel.backgroundColor;
    
    self.captionLabel.font = kTEXT_FONT;
    self.captionLabel.textColor = kTEXT_FONT_COLOR;
    self.captionLabel.backgroundColor = self.locationLabel.backgroundColor;
    self.captionLabel.numberOfLines = 0;

    self.descriptionlabel.font = kTEXT_FONT;
    self.descriptionlabel.textColor = kTEXT_FONT_COLOR;
    self.descriptionlabel.backgroundColor = [UIColor clearColor];
    self.descriptionlabel.numberOfLines = 0;
    
    self.pictureView.layer.cornerRadius = 3;
    
    
    self.captionLabel.backgroundColor = [UIColor clearColor];
    self.coverView = [[UIView alloc] init];
                      
                      
    self.coverView.backgroundColor = [UIColor whiteColor];
    
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44)];
    self.scrollView.scrollEnabled = true;
    self.scrollView.delegate = self;
    [self.self.scrollView addSubview:dropShadow];
    [self.scrollView addSubview:self.pictureBacking];
    [self.scrollView  addSubview:self.pictureView];
    [self.scrollView  addSubview:self.coverView];
    
    [self.scrollView  addSubview:self.locationLabel];
    [self.scrollView  addSubview:self.yearLabel];
    [self.scrollView  addSubview:self.captionLabel];
    [self.scrollView addSubview:self.descriptionlabel];
    [self.self.view addSubview:self.scrollView ];
    
    
    
    // MENU OVERLAY
    
    self.menuOverlay.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.85];
    self.menuOverlay.alpha = 0;
    [self.view addSubview:self.menuOverlay];
    
    hideMenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hideMenuButton addTarget:self action:@selector(hideOverlay) forControlEvents:UIControlEventTouchUpInside];
    hideMenuButton.frame = self.menuOverlay.frame;
    [self.menuOverlay addSubview:hideMenuButton];
    
    facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [facebookButton setImage:[UIImage imageNamed:@"FacebookIcon"] forState:UIControlStateNormal];
    [facebookButton addTarget:self action:@selector(shareWithFacebook) forControlEvents:UIControlEventTouchUpInside];
    [self.menuOverlay addSubview:facebookButton];
    
    twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [twitterButton setImage:[UIImage imageNamed:@"TwitterIcon"] forState:UIControlStateNormal];
    [twitterButton addTarget:self action:@selector(shareWithTwitter) forControlEvents:UIControlEventTouchUpInside];
    [self.menuOverlay addSubview:twitterButton];
    
    mapsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mapsButton setImage:[UIImage imageNamed:@"MapIcon"] forState:UIControlStateNormal];
    [mapsButton addTarget:self action:@selector(showMapsView) forControlEvents:UIControlEventTouchUpInside];
    [self.menuOverlay addSubview:mapsButton];
    
    // NAVIGATION
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStyleBordered target:self action:@selector(popView)];
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor whiteColor]
                                  highlightedColor:[UIColor whiteColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationController class], nil];
    
    moreBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MoreButton"] style:UIBarButtonItemStyleBordered target:self action:@selector(moreButtonPressed)];
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor whiteColor]
                                  highlightedColor:[UIColor whiteColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationController class], nil];
    
    
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    self.navigationItem.rightBarButtonItem = moreBarButtonItem;
    
    UIImageView *navigationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PixtoryNavigation"]];
    
    navigationView.frame = CGRectMake(0, 7,98, 30);
    
    self.navigationItem.titleView = navigationView;
}
- (void)popView
{

    
    NSLog(@"CALLED");
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    NSLog(@"%@", [self.moment objectForKey:@"description"]);
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ContentBackground.png"]];
    
    [self configureSubviews];
    
    NSURL *url = [NSURL URLWithString: [self.moment valueForKeyPath:@"image.full.url"]];
    [self.pictureView setImageWithURL:url];
    self.locationLabel.text = [self.moment valueForKeyPath:@"location.name"];
    self.yearLabel.text = [self.moment valueForKeyPath:@"formatted_timestamp"];
    self.captionLabel.text = [self.moment valueForKeyPath:@"caption"];
    self.descriptionlabel.text = [self.moment valueForKeyPath:@"description"];

    [self.captionLabel sizeToFit];
    
    [self updateFrame];
    [super viewDidLoad];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (id)initWithMoment:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.moment = dictionary;
    }
    return self;
}

- (void) updateFrame
{
    
    
    
    self.menuOverlay.frame = CGRectMake(10, 10, self.pictureView.frame.size.width, self.pictureView.frame.size.height - 20);
    facebookButton.frame = CGRectMake((self.menuOverlay.frame.size.width / 2) - 64 - 32 - 16,
                                      self.menuOverlay.frame.size.height / 2 - 32,
                                      64, 64);
    
    twitterButton.frame = CGRectMake((self.menuOverlay.frame.size.width / 2) -32 ,
                                     self.menuOverlay.frame.size.height / 2 - 32,
                                     64, 64);
    
    mapsButton.frame = CGRectMake((self.menuOverlay.frame.size.width / 2) + 32 + 16,
                                  (self.menuOverlay.frame.size.height / 2 ) - 32,
                                  64, 64);
    
    self.descriptionlabel.frame = CGRectMake(20, self.captionLabel.frame.size.height + self.captionLabel.frame.origin.y + 10, 280, 100);
    [self.descriptionlabel sizeToFit];
    
    dropShadow = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 301, self.coverView.frame.size.height + 1)];
    dropShadow.backgroundColor = [UIColor blackColor];
    dropShadow.alpha = 0.1;
    
    [self.scrollView  addSubview:dropShadow];
    
    NSLog(@"%f", self.descriptionlabel.frame.size.height);
    
    
    int actualCoverHeight = 10 + 10 + self.descriptionlabel.frame.size.height + self.descriptionlabel.frame.origin.y  - 280;
    int minimumCoverHeight = self.view.frame.size.height - 20 - 300 - 25 ;
    
    if (actualCoverHeight > minimumCoverHeight) {
        NSLog(@"is bigger");
        self.coverView.frame = CGRectMake(10, 290, 300, actualCoverHeight);
    } else
    {
        NSLog(@"not bigger");
        self.coverView.frame = CGRectMake(10, 290, 300, minimumCoverHeight);
    }
    
    self.scrollView .contentSize = CGSizeMake(self.view.frame.size.width,
                                         self.coverView.frame.origin.y + self.coverView.frame.size.height + 40 + 30);
    
    
    [self.copyrightButton addTarget:self action:@selector(copyrightButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.copyrightButton.frame = CGRectMake(20, self.scrollView.contentSize.height - 30 - 30, 280, 40);
    self.copyrightButton.backgroundColor = [UIColor clearColor];
    self.copyrightLabel.numberOfLines = 0;
    self.copyrightLabel.frame = self.copyrightButton.frame;
    self.copyrightLabel.textColor = [UIColor grayColor];
    self.copyrightLabel.text = [NSString stringWithFormat:@"Courtesy of %@,\nused under %@", [self.moment objectForKey:@"source_name"], [self.moment objectForKey:@"license"]];
    self.copyrightLabel.font = [UIFont fontWithName:kFONT size:14];
    self.copyrightLabel.backgroundColor = [UIColor clearColor];
    
    [self.copyrightLabel sizeToFit];
    
    
    [self.scrollView addSubview:self.copyrightLabel];
    [self.scrollView addSubview:self.copyrightButton];

}



-(void)moreButtonPressed
{

    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
    
    if (!menuShowing)
    {   // show menu
        [UIView animateWithDuration:0.3 animations:^{
            self.menuOverlay.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.85f];
            self.menuOverlay.alpha = 1.0f;
            
            //self.mapView.alpha = 1.0f;
            
        } completion:^(BOOL finished) {
            
            menuShowing = true;
            
        }];
    } else
    {   // hide menu
        [self hideOverlay];
    }
    
    
}
-(void)hideOverlay
{
    if(!menuShowing) return;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.menuOverlay.alpha = 0.0f;
                         
                     } completion:^(BOOL finished) {
                         
                         menuShowing = false;
                     }];
    
    
    NSLog(@"Hide");
}

-(void)shareWithFacebook
{
    [self moreButtonPressed];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate shareMomentWithFacebook:self.moment andImage:self.pictureView.image];
}

-(void)shareWithTwitter
{
    [self moreButtonPressed];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate shareMomentWithTwitter:self.moment andImage:self.pictureView.image];
}

-(void)showMapsView
{
    [self moreButtonPressed];
    MapsViewController *mapsVC = [[MapsViewController alloc] initWithMoment:self.moment];

    
    [self.navigationController pushViewController:mapsVC animated:YES];
}

- (void)copyrightButtonPressed
{
    NSString* launchUrl = [self.moment objectForKey:@"source_url"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
}

-(void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    pictureViewCoords.x = aScrollView.contentOffset.x;
    pictureViewCoords.y = aScrollView.contentOffset.y;
    
    self.menuOverlay.frame = CGRectMake(10, 10 - aScrollView.contentOffset.y, 300, 280);
    hideMenuButton.frame = self.menuOverlay.frame;
    [self hideOverlay];
}
@end
