//
//  customButton.m
//  VanDutch 40 Club
//
//  Created by Edwin Dario Gutierrez Pech on 2/9/16.
//  Copyright © 2016 Habanero Studio. All rights reserved.
//

#import "customButton.h"
#import "VMacro.h"

@implementation customButton

- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.backgroundColor = PRIMARY_BACKGROUND.CGColor;
    
}


@end
