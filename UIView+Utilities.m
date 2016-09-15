//
//  UIView+Utilities.m
//  VanDutch 40 Club
//
//  Created by Alejandro Cárdenas on 3/13/16.
//  Copyright © 2016 Habanero Studio. All rights reserved.
//

#import "UIView+Utilities.h"

@implementation UIView (Utilities)

- (void)roundCornerWithCornerRadius:(CGFloat)radius {
  [self.layer setCornerRadius:radius];
  [self setClipsToBounds:YES];
}

- (void)addBorderWithWidth:(CGFloat)width color:(UIColor *)color {
  [self.layer setBorderWidth:width];
  [self.layer setBorderColor:[color CGColor]];
}

@end
