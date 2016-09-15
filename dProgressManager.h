//
//  dProgressManager.h
//  VanDutch 40 Club
//
//  Created by Darío Gutiérrez on 2/4/16.
//  Copyright © 2016 Habanero Studio. All rights reserved.
//

/*
 * Manager to show and hide the HUD
 * progress globally
 *
 */

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"


@interface dProgressManager : NSObject <MBProgressHUDDelegate>

+ (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title;
+ (void)dismissGlobalHUD;

@end
