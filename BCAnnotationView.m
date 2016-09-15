//
//  BCAnnotationView.m
//  VanDutch 40 Club
//
//  Created by Darío Gutiérrez on 2/5/16.
//  Copyright © 2016 Habanero Studio. All rights reserved.
//

#import "BCAnnotationView.h"
#import "BCAnnotationPin.h"


@implementation BCAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
            BCAnnotationPin *pinAnnotation = self.annotation;
            switch (pinAnnotation.type) {
                case BMAnnotationGray:
                    self.image = [UIImage imageNamed:@"pinGray.png"];
                    break;
                case BMAnnotationBlue:
                    self.image = [UIImage imageNamed:@"pin_blue.png"];
                    break;
                case BMAnnotationGreen:
                    self.image = [UIImage imageNamed:@"pin_green.png"];
                    break;
                case BMAnnotationYellow:
                    self.image = [UIImage imageNamed:@"pin_yellow.png"];
                    break;
                case BMAnnotationOrange:
                    self.image = [UIImage imageNamed:@"pin_orange.png"];
                    break;
                case BMAnnotationRed:
                    self.image = [UIImage imageNamed:@"pin_red.png"];
                    break;
                case BMAnnotationBlack:
                    self.image = [UIImage imageNamed:@"pin_black.png"];
                    break;
                default:
                    self.image = [UIImage imageNamed:@"pin_gray.png"];
                    break;            
        }
    }
    
    return self;
}

@end
