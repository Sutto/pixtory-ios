//
//  LocationDelegate.h
//  Pixtory
//
//  Created by Darcy Laycock on 1/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Locator : NSObject<CLLocationManagerDelegate>

@property CLLocation *lastLocation;
@property CLLocationManager *manager;

+(Locator *)locator;


-(void)start;
-(void)stop;

@end
