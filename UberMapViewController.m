//
//  UberMapViewController.m
//  Uber Map
//
//  Created by Edwin Dario Gutierrez Pech on 9/14/16.
//  Copyright © 2016 Darío Gutiérrez Mobile Engineer & Designer. All rights reserved.
//

#import "UberMapViewController.h"



#import "UberMapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
//#import "VPickUpVC.h"

#import "BCAnnotationView.h"
#import "BCAnnotationPin.h"

// Aleks C. Barragan
#import "MVPlaceSearchTextField.h"
#import "VDSetPickupLocationView.h"
#import "AnimationManager.h"

#import "VMacro.h"
#import "UIView+Utilities.h"

@interface UberMapViewController ()< MKMapViewDelegate, CLLocationManagerDelegate,UITextFieldDelegate, PlaceSearchTextFieldDelegate>
{
    //CLGeocoder *geoCoder;
}

@property float latitude;
@property float longitude;

@property (strong, nonatomic) AnimationManager   *animationManager;
@property (strong, nonatomic) CLLocationManager  *locationManager;
@property (strong, nonatomic) NSString           *previousAddress;
@property (strong, nonatomic) CLGeocoder         *geoCoder;
@property (weak, nonatomic) IBOutlet MKMapView   *mapView;
@property (weak, nonatomic) IBOutlet UIView      *infoContainerView;
@property (weak, nonatomic) IBOutlet UIView      *setPickupLocationContainerView;
@property (weak, nonatomic) IBOutlet UIButton    *getCurrentLocationButton;
@property (weak, nonatomic) IBOutlet UIButton    *goToCalendar;
@property (weak, nonatomic) IBOutlet UIImageView *placemarkIcon;
@property (weak, nonatomic) IBOutlet MVPlaceSearchTextField *addressTextField;

- (IBAction)getCurrentLocation:(id)sender;

@end

@implementation UberMapViewController

#pragma mark - Life view cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initAnimatorsIfNeeded];
    self.setPickupLocationContainerView.hidden = YES;
    self.addressTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.addressTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self configurePlaceSearchTextField];
    self.title = @"Pick-up Location";
    
    //Map
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.delegate = self;
    [_locationManager requestAlwaysAuthorization];
    _geoCoder = [[CLGeocoder alloc] init];
    _mapView.delegate = self;
    
    [self.goToCalendar addTarget:self action:@selector(goToReservation) forControlEvents:UIControlEventTouchUpInside];
    
    BCAnnotationPin *annotation1 = [[BCAnnotationPin alloc] init];
    annotation1.coordinate = CLLocationCoordinate2DMake(25.769360, -80.198900);
    //annotation1.type = BMAnnotationGray;
    annotation1.title = @"River Yacht Club";
    
    BCAnnotationPin *annotation2 = [[BCAnnotationPin alloc] init];
    annotation2.coordinate = CLLocationCoordinate2DMake(26.1198737, -80.117022);
    //annotation2.type = BMAnnotationGray;
    annotation2.title = @"VanDutch Center Miami Ft. Lauderdale";
    
    BCAnnotationPin *annotation3 = [[BCAnnotationPin alloc] init];
    annotation3.coordinate = CLLocationCoordinate2DMake(25.769392, -80.198920);
    //annotation3.type = BMAnnotationGray;
    annotation3.title = @"VanDutch Center Miami";
    
    [self.mapView addAnnotation:annotation1];
    [self.mapView addAnnotation:annotation2];
    [self.mapView addAnnotation:annotation3];
    
    [self centerMap];
    
    //UI
    [self addLogo];
    [self customView:_infoContainerView];
    [self customButton:_getCurrentLocationButton];
    
}

- (void) viewWillAppear:(BOOL)animated{
    [self locationObserver];
    [UIView animateWithDuration:0.4 delay: 0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
        _placemarkIcon.transform = (CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0));
        _placemarkIcon.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configSetPickupLocationContainerView];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeLocationObserver];
}

#pragma mark - Custom views
- (void) customView: (UIView *)chooseView{
    chooseView.layer.cornerRadius = 4;
    chooseView.layer.borderWidth = 1;
    chooseView.layer.borderColor = SECONDARY_BACKGROUND.CGColor;
}

- (void) customButton: (UIView *)chooseButton{
    chooseButton.layer.cornerRadius = 4;
    chooseButton.layer.borderWidth = 1;
    chooseButton.layer.borderColor = SECONDARY_BACKGROUND.CGColor;
}


- (void) addLogo{
    UIImage *logo = [UIImage imageNamed:@"title_logo"];
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x, -5, 135, 40)];
    [logoImageView setImage:logo];
    [logoImageView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = logoImageView;
}

- (void)configSetPickupLocationContainerView {
    CGRect pickupLocationContainerViewFrame = self.setPickupLocationContainerView.bounds;
    VDSetPickupLocationView *pickupLocationView = [VDSetPickupLocationView view];
    if (pickupLocationView) {
        pickupLocationView.frame = pickupLocationContainerViewFrame;
        pickupLocationView.backgroundColor = PRIMARY_BACKGROUND;
        pickupLocationView.titleLabel.text = @"SELECT PICK UP LOCATION";
        self.setPickupLocationContainerView.alpha = 0.0;
        [self.setPickupLocationContainerView addSubview:pickupLocationView];
        [self.animationManager view:self.setPickupLocationContainerView hidden:NO];
        [self.setPickupLocationContainerView roundCornerWithCornerRadius:pickupLocationContainerViewFrame.size.height/2.0];
    }
}

- (void)initAnimatorsIfNeeded {
    if (!self.animationManager) {
        _animationManager = [[AnimationManager alloc] init];
    }
}

#pragma mark - Map view delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    NSLog(@"%s", __FUNCTION__);
    //    if ([annotation isKindOfClass:[BCAnnotationPin class]]) {
    //
    //        BCAnnotationView *annotationView = [[BCAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PinAsignado"];
    //        annotationView.canShowCallout = YES;
    //        //annotationView.image = [UIImage imageNamed:@"pinGray.png"];
    //        //        UIButton *buton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    //        //        annotationView.rightCalloutAccessoryView =buton;
    //        //        return annotationView;
    //    }
    
    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"PinAsignado"];
    annView.pinColor = MKPinAnnotationColorGreen;
    annView.canShowCallout = YES;
    //    return annView;
    return nil;
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"annotation view: %lf, %lf", [view.annotation coordinate].latitude, [view.annotation coordinate].longitude);
    [self CentrarView:[view.annotation coordinate].latitude longitud:[view.annotation coordinate].longitude Zoom:1.0];
    
}
-(void)centerMap{
    //im a miami beach, tu tu tu rururur tu tu (8)
    [self CentrarView:25.786737 longitud:-80.136756 Zoom:1.5];
}

- (void)CentrarView:(float)latitud longitud:(float)longitud Zoom:(float)zoom{
    
    MKCoordinateRegion regionMapa;
    regionMapa.center = CLLocationCoordinate2DMake(latitud, longitud);
    regionMapa.span.latitudeDelta = zoom;
    regionMapa.span.longitudeDelta = zoom;
    [_mapView setRegion:regionMapa animated:YES];
}


- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    [self.animationManager view:self.setPickupLocationContainerView hidden:YES];
}

- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self.animationManager view:self.setPickupLocationContainerView hidden:NO];
    NSLog(@"%s", __FUNCTION__);
    CLLocation *location = [[CLLocation alloc] initWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
    [self geoCode:location];
}

- (void) geoCode:(CLLocation *)location
{
    [_geoCoder cancelGeocode];
    [_geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        
        if (!placemarks){ //Error
            
        }
        
        if (placemarks && placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
            NSString *address;
            NSString *addressSubThoroughfare  = [placemark subThoroughfare];
            NSString *addressThoroughfare  = [placemark thoroughfare];
            NSString *addressLocality = [placemark locality];
            NSString *addressAdministrativeArea = [placemark administrativeArea];
            
            if (addressSubThoroughfare == nil || addressSubThoroughfare == (id)[NSNull null])
            {
                addressSubThoroughfare = @"";
                if (addressThoroughfare == nil || addressThoroughfare == (id)[NSNull null]){
                    addressThoroughfare = @"";
                    
                    if (addressLocality == nil || addressLocality == (id)[NSNull null]){
                        addressLocality = @"";
                        
                        if (addressAdministrativeArea == nil || addressAdministrativeArea == (id)[NSNull null]){
                            addressAdministrativeArea = @"";
                        }
                    }
                }
                
            }
            
            address = [NSString stringWithFormat:@"%@ %@ %@ %@", addressSubThoroughfare, addressThoroughfare, addressLocality, addressAdministrativeArea];
            NSLog(@"Address: %@", address);
            
            //Now we have the address
            //Use it
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MBDidReceiveAddressNotification" object:self userInfo:@{@"address": address}];
            
            self.latitude = location.coordinate.latitude;
            self.longitude = location.coordinate.longitude;
            
            _addressTextField.text = address;
            _previousAddress = address;
            
        }
        
    }];
    
    
    
}

-(void)goToReservation{
    //    [self performSegueWithIdentifier:@"pickupCalendar" sender:self];
    //[self checkDays];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //Segue to another view
}


#pragma mark - Helpers -

- (NSInteger)indexFromPixels:(NSInteger)pixels
{
    if (pixels == 60)
        return 0;
    else if (pixels == 120)
        return 1;
    else
        return 2;
}

- (NSInteger)pixelsFromIndex:(NSInteger)index
{
    switch (index)
    {
        case 0:
            return 60;
            
        case 1:
            return 120;
            
        case 2:
            return 200;
            
        default:
            return 0;
    }
}

- (IBAction)getCurrentLocation:(id)sender {
    NSLog(@"%s",__FUNCTION__);
    //    _locationManager.delegate = self;
    //    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //
    //    [_locationManager startUpdatingLocation];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateLocationNotification object:nil];
}

#pragma mark - Update current location

- (void)locationObserver {
    [[NSNotificationCenter defaultCenter] addObserverForName:kCurrentLocationNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        if (note.object) {
            CLLocation *location = note.object;
            [self CentrarView:location.coordinate.latitude longitud:location.coordinate.longitude Zoom:0.01];
        } else {
            //TODO: manage when location object is nil
            // note.object is nil
        }
    }];
}

- (void)removeLocationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCurrentLocationNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Hide Keyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
}





#pragma mark - Place search text field

- (void)configurePlaceSearchTextField {
    [self.addressTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.addressTextField setPlaceSearchDelegate:self];
    [self.addressTextField setStrApiKey:kGoogleMapsAPIKey];
    [self.addressTextField setSuperViewOfList:self.view];
    [self.addressTextField setAutoCompleteShouldHideOnSelection:YES];
    [self.addressTextField setMaximumNumberOfAutoCompleteRows:8];
    [self.addressTextField setTextColor:[UIColor colorWithRed:63/255.0 green:82/255.0 blue:99/255.0 alpha:1.0]];
    [self.addressTextField setAutoCompleteTableCellTextColor:[self.addressTextField textColor]];
}


#pragma mark - Place search text field delegate
-(void)placeSearch:(MVPlaceSearchTextField*)textField ResponseForSelectedPlace:(GMSPlace*)responseDict{
    [self.view endEditing:YES];
    NSLog(@"SELECTED ADDRESS :%@",responseDict);
    NSLog(@"\n\nCoordinate: (lat, long) = (%lf, %lf)", (double)responseDict.coordinate.latitude, (double)responseDict.coordinate.longitude);
    [self CentrarView:(float)responseDict.coordinate.latitude longitud:(float)responseDict.coordinate.longitude Zoom:0.005];
}
-(void)placeSearchWillShowResult:(MVPlaceSearchTextField*)textField{
    
}
-(void)placeSearchWillHideResult:(MVPlaceSearchTextField*)textField{
    
}
-(void)placeSearch:(MVPlaceSearchTextField*)textField ResultCell:(UITableViewCell*)cell withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index{
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Days

//- (void)checkDays {
//    NSDateFormatter *formatter = [NSDateFormatter new];
//    [formatter setDateFormat:@"MM/dd/yyyy"];
//    
//    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
//    
//    NSDictionary *parameters = @{
//                                 @"date" : [NSString stringWithFormat:@"%@",dateStr]
//                                 };
//    
//    [ServiceAPI checkAvailabilityPerMonth:parameters success:^(NSDictionary *dictionary) {
//        NSLog(@"*** %@", dictionary);
//        NSDictionary *response = dictionary;
//        
//        //        UIAlertView *alert;
//        
//        int code = [[response objectForKey:@"code"]intValue];
//        
//        if (code != 200) {
//            NSLog(@"%@",[response  objectForKey:@"message"]);
//        } else {
//            //TODO: ver como cancelar los dias del arreglo del mes
//            //            {
//            //                "message": "not available this day",
//            //                "code": "200",
//            //                "days": [
//            //                         {
//            //                             "day": "02/28/2016"
//            //                         },
//            //                         {
//            //                             "day": "02/29/2016"
//            //                         }
//            //                         ]
//            //            }
//            NSLog(@"%@",[response  objectForKey:@"message"]);
//            
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            NSString *reservationDatesKey = @"reservationDates";
//            NSMutableDictionary *reservationsDict = nil;
//            if ([userDefaults objectForKey:reservationDatesKey]) {
//                reservationsDict = [[NSMutableDictionary alloc] initWithDictionary:[userDefaults objectForKey:reservationDatesKey]];
//            } else {
//                reservationsDict = [NSMutableDictionary new];
//            }
//            
//            if ([response[@"days"] isKindOfClass:[NSArray class]]) {
//                NSArray *reservations = response[@"days"];
//                for (NSDictionary *reservationDate in reservations) {
//                    reservationsDict[reservationDate[@"day"]] = reservationDate;
//                }
//                [[NSUserDefaults standardUserDefaults] setObject:reservationsDict forKey:@"reservationDates"];
//                
//            }
//        }
//        
//        [self.view setUserInteractionEnabled:YES];
//        [dProgressManager dismissGlobalHUD];
//        [self performSegueWithIdentifier:@"pickupCalendar" sender:self];
//        
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [self.view setUserInteractionEnabled:YES];
//        [dProgressManager dismissGlobalHUD];
//        [self performSegueWithIdentifier:@"pickupCalendar" sender:self];
//    }];
//}


@end