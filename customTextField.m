//
//  customTextField.m
//  VanDutch 40 Club
//
//  Created by Edwin Dario Gutierrez Pech on 2/9/16.
//  Copyright © 2016 Habanero Studio. All rights reserved.
//

#import "customTextField.h"

IB_DESIGNABLE
@implementation customTextField

-(void) drawRect:(CGRect)rect
{
    //self.frame = CGRectInset(self.frame, 2.0f, 2.0f);
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor.CGColor;
    //self.layer.backgroundColor = self.bgColor.CGColor;
    self.layer.cornerRadius = 6;//self.cornerRadius;

    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)
                                           cornerRadii:CGSizeMake(6.0, 6.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    //maskLayer.lineWidth = 2;
    //maskLayer.strokeColor = PRIMARY_BORDER_COLOR.CGColor;
    //maskLayer.fillColor = [UIColor clearColor].CGColor;
    self.layer.mask = maskLayer;

    //[self.layer addSublayer:maskLayer];

}

-(CGRect) textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 20, 0);
}

-(CGRect) editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

@end
