//
//  BCAnnotationPin.h
//  VanDutch 40 Club
//
//  Created by Darío Gutiérrez on 2/5/16.
//  Copyright © 2016 Habanero Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef NS_ENUM(NSInteger, BMAnnotationType) {
    BMAnnotationDefault = 0,
    BMAnnotationGray, /**  */
    BMAnnotationBlue, /**  */
    BMAnnotationGreen,/***/
    BMAnnotationYellow,/** */
    BMAnnotationOrange,/** */
    BMAnnotationRed,/** */
    BMAnnotationBlack,/** */
};
@interface BCAnnotationPin : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic) BMAnnotationType type;

@end
