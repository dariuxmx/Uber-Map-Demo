//
//  customLabel.m
//  VanDutch 40 Club
//
//  Created by Edwin Dario Gutierrez Pech on 2/13/16.
//  Copyright © 2016 Habanero Studio. All rights reserved.
//

#import "customLabel.h"
#import "VMacro.h"

IB_DESIGNABLE

@implementation customLabel

- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.layer.backgroundColor = PRIMARY_BACKGROUND.CGColor;
    //self.textColor = [UIColor whiteColor];
    
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)
                                           cornerRadii:CGSizeMake(6.0, 6.0)];

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;

}


@end
