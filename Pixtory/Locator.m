//
//  LocationDelegate.m
//  Pixtory
//
//  Created by Darcy Laycock on 1/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//

#import "Locator.h"

@implementation Locator

@synthesize lastLocation;
@synthesize manager;

+(Locator *)locator {
    static Locator *locator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locator = [self new];
    });
    return locator;
}

-(id)init {
    if (self = [super init]) {
        self.manager = [CLLocationManager new];
        manager.delegate = self;
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.lastLocation = [locations lastObject];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdatedLocation" object:self];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error = %@", error);
}

-(void)start {
    manager.desiredAccuracy = 250.0;
    [manager startUpdatingLocation];
}

-(void)stop {
    [manager stopUpdatingLocation];
}

@end
