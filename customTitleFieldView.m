//
//  customTitleFieldView.m
//  VanDutch 40 Club
//
//  Created by Edwin Dario Gutierrez Pech on 2/14/16.
//  Copyright © 2016 Habanero Studio. All rights reserved.
//

#import "customTitleFieldView.h"

IB_DESIGNABLE
@implementation customTitleFieldView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
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
