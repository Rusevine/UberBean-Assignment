//
//  ViewController.m
//  UberBean
//
//  Created by Wiljay Flores on 2018-08-17.
//  Copyright © 2018 wiljay. All rights reserved.
//

#import "ViewController.h"
#import "NetworkManager.h"
#import "Cafe.h"


@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, strong) CLLocationManager *location;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) NSArray<Cafe *> *annotations;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.location = [[CLLocationManager alloc] init];
    self.location.delegate = self;
    [self.location requestWhenInUseAuthorization];
    self.location.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.location.distanceFilter = kCLDistanceFilterNone;
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;

    [NetworkManager getCoffee:self.location.location andCompletion:^(NSArray *completion){
        self.annotations = completion;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.mapView addAnnotations:self.annotations];
            [self.mapView registerClass:[MKPinAnnotationView class] forAnnotationViewWithReuseIdentifier:@"pinAnnotation"];
            [self.mapView showAnnotations:self.annotations animated:YES];
        }];
    }];

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
            NSLog(@"Location: %f, %f",self.location.location.coordinate.latitude, self.location.location.coordinate.longitude);
            break;
    }

    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if([annotation isKindOfClass:[Cafe class]]){
        MKPinAnnotationView *pin = [mapView dequeueReusableAnnotationViewWithIdentifier:@"pinAnnotation"];
        return pin;
    }
    return nil;
}


@end
