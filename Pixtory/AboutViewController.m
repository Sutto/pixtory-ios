//
//  AboutViewController.m
//  Pixtory
//
//  Created by Andyy Hope on 2/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//

#import "AboutViewController.h"
#import "UIBarButtonItem+FlatUI.h"
#import "Appearance.h"
@interface AboutViewController ()
{
    UIScrollView *contentScrollView;
    UIImageView *teamPicture;
    UILabel *bodyTextLabel;
    UILabel *copyrightLabel;
}
@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStyleBordered target:self action:@selector(popView)];
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor whiteColor]
                                  highlightedColor:[UIColor whiteColor]
                                      cornerRadius:0
                                   whenContainedIn:[UINavigationController class], nil];
    
        
    
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    UIImageView *navigationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PixtoryNavigation"]];
    
    navigationView.frame = CGRectMake(0, 7,98, 30);
    
    self.navigationItem.titleView = navigationView;
    
    
    
    
    contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    contentScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ContentBackground"]];
    [self.view addSubview:contentScrollView];
    
    [self updateScrollView];
}
-(void)updateScrollView
{
    
    teamPicture = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 200)];
    teamPicture.image = [UIImage imageNamed:@"PixtoryTeam"];
    
    UIView *dropshadowView = [[UIView alloc] init];
    dropshadowView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.1f];
    [contentScrollView addSubview:dropshadowView];
    [contentScrollView addSubview:teamPicture];
     
    NSString *andyyString = @"Andyy Hope\n@AndyyHope\niOS Developer, Designer";
    NSString *darcyString = @"Darcy Laycock\n@Sutto\nRuby Developer";
    NSString *joString = @"Jo Hawkins\n@History_Punk \nHistorian";
    NSString *mattString = @"Matt Didcoe\n @MattMan\nRuby Developer";
    NSString *daveString = @"Dave Newman\n@DaveJamesNewman \nInformation Architect";
    NSString *daveAdamsString = @"Dave Adams\n@SolutionSmith\nProject Manager";
    
    bodyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, 300, 550)];
    bodyTextLabel.font = kTEXT_FONT;
    bodyTextLabel.backgroundColor = [UIColor whiteColor];
    bodyTextLabel.textAlignment = NSTextAlignmentCenter;
    bodyTextLabel.text = [NSString stringWithFormat:@"%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@", daveAdamsString, daveString, joString, andyyString, mattString, darcyString];
    bodyTextLabel.numberOfLines = 0;
    
    copyrightLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, bodyTextLabel.frame.size.height + bodyTextLabel.frame.origin.y + 20 - 80, 300, 200)];
    copyrightLabel.font = [UIFont fontWithName:kFONT size:14];
    copyrightLabel.textColor = [UIColor grayColor];
    copyrightLabel.backgroundColor = [UIColor clearColor];
    copyrightLabel.numberOfLines = 0;
    copyrightLabel.textAlignment = NSTextAlignmentCenter;
    
    copyrightLabel.text = @"Images copyright their respective owners, used under Creative Commons Licenses.\nSee each individual image page for more specifics.";
    contentScrollView.contentSize = CGSizeMake(self.view.frame.size.width, copyrightLabel.frame.size.height + copyrightLabel.frame.origin.y);
    dropshadowView.frame = CGRectMake(10, 10, 301, bodyTextLabel.frame.size.height + bodyTextLabel.frame.origin.y - 9);
    [contentScrollView addSubview:bodyTextLabel];
    [contentScrollView addSubview:copyrightLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)popView
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
