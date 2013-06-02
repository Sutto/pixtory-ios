//
//  MainViewTableCell.h
//  Pixtory
//
//  Created by Andyy Hope on 1/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MainViewTableCell : UITableViewCell
{
    
}
@property (nonatomic, retain) NSDictionary *moment;
@property (nonatomic, retain) UILabel *streetLabel;
@property (nonatomic, retain) UILabel *yearLabel;
@property (nonatomic, retain) UIImageView *pictureView;
@end
