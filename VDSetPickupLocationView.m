//
//  VDSetPickupLocationView.m
//  VanDutch 40 Club
//
//  Created by Alejandro Cárdenas on 4/13/16.
//  Copyright © 2016 Habanero Studio. All rights reserved.
//

#import "VDSetPickupLocationView.h"
#import "VMacro.h"

@implementation VDSetPickupLocationView

+ (id)view {
  static UINib *nib;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
  });
  
  NSArray *nibObjects = [nib instantiateWithOwner:nil options:nil];
  for (id object in nibObjects) {
    if ([object isKindOfClass:[self class]]) {
      return object;
    }
  }
  
  return nil;
}

- (void)awakeFromNib {
  self.backgroundColor = PRIMARY_BACKGROUND;
}

@end
