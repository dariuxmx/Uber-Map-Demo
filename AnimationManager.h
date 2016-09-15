//
//  AnimationManager.h
//  VanDutch 40 Club
//
//  Created by Edwin Dario Gutierrez Pech on 2/29/16.
//  Copyright © 2016 Habanero Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "customTitleFieldView.h"

@interface AnimationManager : NSObject

@property (nonatomic)         NSTimeInterval animationTimeInterval;
@property (nonatomic, strong) NSNumber       *constantNumber;

- (void) animateTextfieldWithView:(customTitleFieldView *)customView Sx:(CGFloat)sx Sy:(CGFloat)sy Tx:(CGFloat)tx Ty:(CGFloat)ty;

- (void)animateView:(UIView *)view withWidthConstraint:(NSLayoutConstraint *)width viewController:(UIViewController *)viewController completionBlock:(void(^)(BOOL completed))completion;
/**
 @brief It takes an array of constraints and constant values to animate. The constraint element must match the same element in the values array which you want to change its constant to.
 @author Aleks C. Barragan
 @date added 8/April/2016
 */
- (void)animateConstraints:(NSArray *)constraints constantValues:(NSArray *)values viewController:(UIViewController *)viewController completionBlock:(void(^)(BOOL completed))completion;


/**
 @brief The view provided will be hidden or shown animating its alpha value then setting its hidden property
 @author Aleks C. Barragan
 @date added April/13/2016
 */
- (void)view:(UIView *)view hidden:(BOOL)hidden;
@end
