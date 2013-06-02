//
//  MainViewController.m
//  Pixtory
//
//  Created by Andyy Hope on 1/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewTableCell.h"
#import "REMenu.h"
#import "UIBarButtonItem+FlatUI.h"
#import "APIClient.h"
#import "SVProgressHUD.h"
#import "AFNetworking/UIImageView+AFNetworking.h"
#import "MomentViewController.h"
#import "AboutViewController.h"

@interface MainViewController () <UIScrollViewDelegate>
{
    REMenu *navMenu;
    NSArray *dataArray;
    NSArray *yearsArray;
    NSMutableArray *imagesArray;
    NSArray *streetsArray;
    UIView *loadingHudView;
    BOOL initialLoaded;
}

-(void)loadNearbyItems;
-(void)refreshPulled:(id)sender;
-(void)hideLoadingView;
-(void)updateInitialLocationFromNotification:(NSNotification *)note;
@end

@implementation MainViewController

-(void)loadMomentFromId:(NSString *)identifier {
    [self createLoadingView];
    [[APIClient client] findMoment:identifier success:^(NSDictionary *moment) {
        [self hideLoadingView];
        MomentViewController *mvc = [[MomentViewController alloc] initWithMoment:moment];
        [self.navigationController pushViewController:mvc animated:YES];
    }];
}

-(void)updateInitialLocationFromNotification:(NSNotification *)note {
    if(initialLoaded) return;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UpdatedLocation" object:nil];
    NSLog(@"Got location, loading initial.");
    initialLoaded = YES;
    [self hideLoadingView];
    [self loadNearbyItems];
}

-(void)hideLoadingView {
    [loadingHudView removeFromSuperview];
    loadingHudView = nil;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint scrollViewPoint;
    scrollViewPoint.y = scrollView.contentOffset.y;
    loadingHudView.frame = CGRectMake((self.view.frame.size.width / 2) - 50,
                                      (self.view.frame.size.height / 2) - 80 + scrollViewPoint.y,
                                      100, 100);
}
-(void)loadNearbyItems {
    if(loadingHudView != nil) return;
    [self createLoadingView];
    [[APIClient client] findNearbyMoments:^(NSArray *array) {
        dataArray = [NSArray arrayWithArray:array];
        // load botom footer padding
        UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        UIImageView *bottomIconImage = [[UIImageView alloc] initWithFrame:CGRectMake((tableFooterView.frame.size.width/2) - 15, 40, 30, 25)];
        bottomIconImage.image = [UIImage imageNamed:@"PixtoryBottomIcon"];
        [tableFooterView addSubview:bottomIconImage];
        self.tableView.tableFooterView = tableFooterView;
        [self.tableView reloadData];
        [self hideLoadingView];

    }];
}

-(void)refreshPulled:(id)sender {
    [self.refreshControl endRefreshing];
    [self loadNearbyItems];
}

- (void)viewDidLoad
{
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ContentBackground.png"]];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshPulled:) forControlEvents:UIControlEventValueChanged];
    
    initialLoaded = [Locator locator].lastLocation != nil;
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"Pixtory";
    
    [self createNavigationMenu];
    
    // TODO: Wait until we get a location, then render it.
    NSLog(@"Waiting for location...");
    [self createLoadingView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateInitialLocationFromNotification:) name:@"UpdatedLocation" object:nil];
    
    
    
    
    
}
- (void)createLoadingView
{
    if(loadingHudView != nil) return;
    NSArray *animationArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"01"],[UIImage imageNamed:@"02"],[UIImage imageNamed:@"03"],[UIImage imageNamed:@"04"],[UIImage imageNamed:@"05"],[UIImage imageNamed:@"01"],[UIImage imageNamed:@"01"],[UIImage imageNamed:@"01"],[UIImage imageNamed:@"01"],[UIImage imageNamed:@"01"],[UIImage imageNamed:@"01"],[UIImage imageNamed:@"01"],[UIImage imageNamed:@"01"],[UIImage imageNamed:@"01"],[UIImage imageNamed:@"01"],[UIImage imageNamed:@"01"],[UIImage imageNamed:@"01"],[UIImage imageNamed:@"01"], nil];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ContentBackground"]];
    
    loadingHudView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 2) - 50,
                                                                      (self.view.frame.size.height / 2) - 80,
                                                                      100, 100)];
    loadingHudView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
    [self.view addSubview:loadingHudView];
    UIImageView *animationView = [[UIImageView alloc]initWithFrame:CGRectMake((loadingHudView.frame.size.width / 2) - 20,
                                                                              (loadingHudView.frame.size.height / 2) - 20,
                                                                              40, 40)];
    animationView.backgroundColor = [UIColor clearColor];
    animationView.animationImages = animationArray;
    animationView.animationDuration = 0.9;
    animationView.animationRepeatCount = 0;
    [animationView startAnimating];
    [loadingHudView addSubview:animationView];
}

- (void)createNavigationMenu
{
    
    UIImageView *navigationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PixtoryNavigation"]];
    
    navigationView.frame = CGRectMake(0, 7,98, 30);
    
    self.navigationItem.titleView = navigationView;
    
    // RE Menu
    REMenuItem *homeItem = [[REMenuItem alloc] initWithTitle:@"Home"
                                                    subtitle:nil
                                                       image:[UIImage imageNamed:@"Icon_Home"]
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          NSLog(@"Item: %@", item);
                                                      }];
    
    REMenuItem *exploreItem = [[REMenuItem alloc] initWithTitle:@"Explore"
                                                       subtitle:nil
                                                          image:[UIImage imageNamed:@"Icon_Explore"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                         }];
    
    REMenuItem *settingsItem = [[REMenuItem alloc] initWithTitle:@"Settings"
                                                        subtitle:nil
                                                           image:[UIImage imageNamed:@"Icon_Activity"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              NSLog(@"Item: %@", item);
                                                          }];
    
    REMenuItem *aboutItem = [[REMenuItem alloc] initWithTitle:@"About Us"
                                                          image:[UIImage imageNamed:@"Icon_Profile"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             AboutViewController *aboutViewController = [[AboutViewController alloc] init];
                                                             [self.navigationController pushViewController: aboutViewController animated:YES];
                                                         }];
    
    navMenu = [[REMenu alloc] initWithItems:@[aboutItem]];

    UIBarButtonItem *menuBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MenuIcon"] style:UIBarButtonItemStyleBordered target:self action:@selector(toggleNavigationMenu)];
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor whiteColor]
                                  highlightedColor:[UIColor whiteColor]
                                      cornerRadius:3
                                   whenContainedIn:[UINavigationController class], nil];
    

    self.navigationItem.leftBarButtonItem = menuBarButtonItem;
}

- (void)toggleNavigationMenu
{
    if (navMenu.isOpen)
        return [navMenu close];
    
    [navMenu showFromNavigationController:self.navigationController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 340;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView registerClass:[MainViewTableCell class] forCellReuseIdentifier:@"Cell"];
    static NSString *CellIdentifier = @"Cell";
    MainViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSDictionary *data = [dataArray objectAtIndex:indexPath.row];
    cell.moment = data;
    [cell.pictureView setImageWithURL:[NSURL URLWithString:[data valueForKeyPath:@"image.primary.url"]]];
    cell.streetLabel.text = [data valueForKeyPath:@"location.name"];
    cell.yearLabel.text = [data objectForKey:@"formatted_timestamp"];
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *moment = [dataArray objectAtIndex:indexPath.row];
    MomentViewController *mvc = [[MomentViewController alloc] initWithMoment:moment];
    [self.navigationController pushViewController:mvc animated:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NearbyListScrolling" object:self];
}

@end

