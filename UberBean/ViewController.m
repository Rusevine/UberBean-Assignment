//
//  ViewController.m
//  UberBean
//
//  Created by Wiljay Flores on 2018-08-17.
//  Copyright © 2018 wiljay. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, strong) CLLocationManager *location;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.location = [[CLLocationManager alloc] init];
    self.location.delegate = self;
    [self.location requestWhenInUseAuthorization];
    self.location.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.location.distanceFilter = kCLDistanceFilterNone;
    
 //   [self.location startUpdatingLocation];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
                                  
    //43.6446486, -79.3971874

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"update");
    MKCoordinateRegion region = MKCoordinateRegionMake(locations[0].coordinate, MKCoordinateSpanMake(0.004, 0.004));
    [self.mapView setRegion:region animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"error");
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    switch(status){
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
            [self.location requestLocation];
            break;
        
    }
    
    
}


@end
