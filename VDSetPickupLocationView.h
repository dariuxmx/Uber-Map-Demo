//
//  VDSetPickupLocationView.h
//  VanDutch 40 Club
//
//  Created by Alejandro Cárdenas on 4/13/16.
//  Copyright © 2016 Habanero Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VDSetPickupLocationView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (VDSetPickupLocationView *)view;

@end
