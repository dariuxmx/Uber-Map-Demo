//
//  AnimationManager.m
//  VanDutch 40 Club
//
//  Created by Edwin Dario Gutierrez Pech on 2/29/16.
//  Copyright © 2016 Habanero Studio. All rights reserved.
//

#import "AnimationManager.h"
#import "customTitleFieldView.h"

@implementation AnimationManager

- (instancetype)init {
  self = [super init];
  
  if (self) {
    _constantNumber = @(0);
    _animationTimeInterval = 0.25;
  }
  
  return self;
}


- (void) animateTextfieldWithView:(customTitleFieldView *)customView Sx:(CGFloat)sx Sy:(CGFloat)sy Tx:(CGFloat)tx Ty:(CGFloat)ty {
    CGAffineTransform scaleTrans;
    CGAffineTransform lefttorightTrans;

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    scaleTrans  = CGAffineTransformMakeScale(sx, sy);
    lefttorightTrans  = CGAffineTransformMakeTranslation(tx,ty);
    customView.transform = CGAffineTransformConcat(scaleTrans, lefttorightTrans);
    
    [UIView commitAnimations];
}

- (void)animateView:(UIView *)view withWidthConstraint:(NSLayoutConstraint *)width viewController:(UIViewController *)viewController completionBlock:(void (^)(BOOL))completion {
  
  [width setConstant:self.constantNumber.floatValue];
  
  [UIView animateWithDuration:0.25 animations:^{
    [viewController.view layoutIfNeeded];
  } completion:^(BOOL finished) {
    completion(finished);
  }];
  
}

- (void)animateConstraints:(NSArray *)constraints constantValues:(NSArray *)values viewController:(UIViewController *)viewController completionBlock:(void (^)(BOOL))completion {
  
  // verify arrays have the same number of elements then if every element corresponds its correct class.
  if (!([constraints count] == [values count])) {
    return;
  }
  
  BOOL validItems = YES;
  for (id constraint in constraints) {
    if (![constraint isKindOfClass:[NSLayoutConstraint class]]) {
      validItems = NO;
    }
  }
  
  for (id value in values) {
    if (![value isKindOfClass:[NSNumber class]]) {
      validItems = NO;
    }
  }
  
  if (validItems) {
    [constraints enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      NSNumber *value = values[idx];
      NSLayoutConstraint *constraint = obj;
      [constraint setConstant:[value floatValue]];
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
      [viewController.view layoutIfNeeded];
    } completion:^(BOOL finished) {
      completion(finished);
    }];
  }
}


- (void)view:(UIView *)view hidden:(BOOL)hidden {
  if (!view) {
    return;
  }
  
  NSTimeInterval animationTimeInterval = self.animationTimeInterval;
  CGFloat finalAlphaValue;
  if (hidden) {
    finalAlphaValue = 0.0;
  } else {
    finalAlphaValue = 1.0;
  }
  
  [UIView animateWithDuration:animationTimeInterval animations:^{
    view.alpha = finalAlphaValue;
  } completion:^(BOOL finished) {
    view.hidden = hidden;
  }];
}

@end
