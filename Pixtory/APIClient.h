//
//  APIClient.h
//  Pixtory
//
//  Created by Darcy Laycock on 1/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "AFNetworking.h"

@interface APIClient : NSObject

+(APIClient *)client;

-(void)findNearbyMoments:(void(^)(NSArray *))callback;
-(void)findMoment:(NSString *)identifier success:(void (^)(NSDictionary *))callback;
-(NSString *)currentLatLng;


@end
