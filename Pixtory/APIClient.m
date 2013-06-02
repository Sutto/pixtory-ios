//
//  APIClient.m
//  Pixtory
//
//  Created by Darcy Laycock on 1/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//

#import "APIClient.h" 

@implementation APIClient

+(APIClient *)client {
    static dispatch_once_t onceToken;
    static APIClient *client;
    dispatch_once(&onceToken, ^{
        client = [self new];
    });
    return client;
}

-(NSString *)currentLatLng {
    AppDelegate *ad = (AppDelegate *)([UIApplication sharedApplication].delegate);
    CLLocation *location = ad.locationManager.lastLocation;
    if(location != nil) {
        return [NSString stringWithFormat:@"lat=%f&lng=%f", location.coordinate.latitude, location.coordinate.longitude];
    } else {
        return @"default=true";
    }
}

-(void)findMoment:(NSString *)identifier success:(void (^)(NSDictionary *))callback {
    NSString *urlString = [NSString stringWithFormat:@"http://pixtory.herokuapp.com/moments/%@", identifier];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    callback = [callback copy];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if(callback) callback([JSON valueForKey:@"moment"]);
    } failure:nil];
    [operation start];
}

-(void)findNearbyMoments:(void (^)(NSArray *))callback {
    NSLog(@"Fetching nearby to %@", [self currentLatLng]);
    NSString *urlString = [NSString stringWithFormat:@"http://pixtory.herokuapp.com/moments?%@", [self currentLatLng]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    callback = [callback copy];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if(callback) callback([JSON valueForKey:@"moments"]);
    } failure:nil];
    [operation start];
}

@end
