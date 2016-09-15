//
//  dProgressManager.m
//  VanDutch 40 Club
//
//  Created by Darío Gutiérrez on 2/4/16.
//  Copyright © 2016 Habanero Studio. All rights reserved.
//

#import "dProgressManager.h"

@implementation dProgressManager


+ (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.labelText = title;
    return hud;
}

+ (void)dismissGlobalHUD {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD hideHUDForView:window animated:YES];
}

@end
