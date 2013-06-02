//
//  MapsViewController.m
//  Pixtory
//
//  Created by Andyy Hope on 2/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//

#import "MapAnnotation.h"

#import "MapsViewController.h"
#import "UIBarButtonItem+FlatUI.h"
@interface MapsViewController () <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView   *mapView;
@end


@implementation MapsViewController

- (id)initWithMoment:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.moment = dictionary;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    self.mapView.backgroundColor = [UIColor blackColor];
    [self addMapMarker];
    [self.view addSubview:self.mapView];
    
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackArrow"] style:UIBarButtonItemStyleBordered target:self action:@selector(dismissView)];
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor whiteColor]
                                  highlightedColor:[UIColor whiteColor]
                                      cornerRadius:0
                                   whenContainedIn:[UINavigationController class], nil];
    
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    UIBarButtonItem *actionBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ShareIcon"] style:UIBarButtonItemStyleBordered target:self action:@selector(openMaps)];
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor whiteColor]
                                  highlightedColor:[UIColor whiteColor]
                                      cornerRadius:0
                                   whenContainedIn:[UINavigationController class], nil];
    
    self.navigationItem.rightBarButtonItem = actionBarButtonItem;
    
    
    
    UIImageView *navigationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PixtoryNavigation"]];
    
    navigationView.frame = CGRectMake(0, 7,98, 30);
    
    self.navigationItem.titleView = navigationView;
}
- (void)dismissView
{
    NSLog(@"Dismissview");
    [self.navigationController popViewControllerAnimated:YES];


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addMapMarker {
    NSDictionary *location = [self.moment valueForKey:@"location"];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([[location valueForKey:@"lat"] doubleValue], [[location valueForKey:@"lng"] doubleValue]);
    MapAnnotation *annotation = [[MapAnnotation alloc] initWithTitle:[location valueForKey:@"name"] andCoordinate:coordinate];
    [self.mapView addAnnotation:annotation];
}

- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
	MKAnnotationView *annotationView = [views objectAtIndex:0];
	id <MKAnnotation> mp = [annotationView annotation];
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 1500, 1500);
	[mv setRegion:region animated:YES];
	[mv selectAnnotation:mp animated:YES];
}


- (void)openMaps
{
//    NSString* launchUrl = [self.moment objectForKey:@"source_url"];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
    
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        // Create an MKMapItem to pass to the Maps app
        NSDictionary *location = [self.moment valueForKey:@"location"];
        CLLocationCoordinate2D coordinate =
        CLLocationCoordinate2DMake([[location valueForKey:@"lat"] doubleValue], [[location valueForKey:@"lng"] doubleValue]);
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:@"My Place"];
        
        // Set the directions mode to "Walking"
        // Can use MKLaunchOptionsDirectionsModeDriving instead
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking};
        // Get the "Current User Location" MKMapItem
        MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
        // Pass the current location and destination map items to the Maps app
        // Set the direction mode in the launchOptions dictionary
        [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem]
                       launchOptions:launchOptions];
    }
}
@end
