//
//  VMacro.h
//  VanDutch 40 Club
//
//  Created by Darío Gutiérrez on 2/2/16.
//  Copyright © 2016 Habanero Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Class with some extra functions for the app.
 */

#if DEBUG
#define DebugLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#endif

#define SYSTEM_VERSION_LESS_THAN(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kGoogleMapsAPIKey @"AIzaSyAAPa5QjiL6oMm3qopwuxyrbn83MSvpEBk" // aleks c. barragan's acc

/* Notification names for notification center */
#define kCurrentLocationNotification @"currentLocation"
#define kUpdateLocationNotification @"updateLocation"
#define kProfileUserLocationNotification @"userLocation"
 

/**
 UI Property Components
 */
#define PRIMARY_BORDER_WIDTH = 1
#define PRIMARY_CORNER_RADIUS = 6.0
#define PRIMARY_BORDER_COLOR UIColorFromRGB(0xA19B9E)
/**
 Colors
 */

//Font
#define FONT_MEDIUM @"DIN-Medium"
#define FONT_REGULAR @"DIN-Regular"
#define FONT_BOLD @"DIN-Bold"

//Colors
//Sintaxis Prefix COLOR + ColorName + item, view, component, etc + hexadecimal value

//Backgrounds
#define PRIMARY_BACKGROUND UIColorFromRGB(0x3C5268)
#define SECONDARY_BACKGROUND UIColorFromRGB(0xE0E0E0)

//Fonts
#define PRIMARY_TEXT UIColorFromRGB(0xFFFFFF)
#define SECONDARY_TEXT UIColorFromRGB(0x3C5268) //Dark blue
#define PRIMARY_TEXT_BUTTON UIColorFromRGB(0Xf8f6ed) //Light yellow almost white


