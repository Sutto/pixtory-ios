//
//  MomentViewController.h
//  Pixtory
//
//  Created by Darcy Laycock on 1/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MomentViewController : UIViewController

@property (nonatomic, strong) NSDictionary *moment;

- (id)initWithMoment:(NSDictionary *)dictionary;

@end
