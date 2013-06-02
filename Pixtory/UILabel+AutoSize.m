//
//  UILabel+AutoSize.m
//  Pixtory
//
//  Created by Andyy Hope on 1/06/13.
//  Copyright (c) 2013 Andyy Hope. All rights reserved.
//

#import "UILabel+AutoSize.h"

@implementation UILabel (AutoSize)
- (void) autosizeForWidth: (int) width {
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.numberOfLines = 0;
    CGSize maximumLabelSize = CGSizeMake(width, FLT_MAX);
    CGSize expectedLabelSize = [self.text sizeWithFont:self.font constrainedToSize:maximumLabelSize lineBreakMode:self.lineBreakMode];
    CGRect newFrame = self.frame;
    newFrame.size.height = expectedLabelSize.height;
    self.frame = newFrame;
}
@end
