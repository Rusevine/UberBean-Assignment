//
//  Cafe.h
//  UberBean
//
//  Created by Wiljay Flores on 2018-08-18.
//  Copyright © 2018 wiljay. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
@import MapKit;

@interface Cafe : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
-(instancetype)initWithShop:(NSDictionary *)shop;


@end
