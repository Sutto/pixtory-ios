//
//  MapsViewController.h
//  Pixtory
//
//  Created by Andyy Hope on 2/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapsViewController : UIViewController
@property (nonatomic, strong) NSDictionary *moment;
- (id)initWithMoment:(NSDictionary *)dictionary;
@end
