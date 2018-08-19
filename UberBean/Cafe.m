//
//  Cafe.m
//  UberBean
//
//  Created by Wiljay Flores on 2018-08-18.
//  Copyright © 2018 wiljay. All rights reserved.
//

#import "Cafe.h"

@interface Cafe ()
@property (nonatomic) NSDictionary *shopInfo;
@end

@implementation Cafe

- (instancetype)initWithShop:(NSDictionary *)shop
{
    self = [super init];
    if (self) {
        _shopInfo = shop;
        CLLocationDegrees latitude = [shop[@"coordinates"][@"latitude"] doubleValue];
        CLLocationDegrees longitude = [shop[@"coordinates"][@"longitude"] doubleValue];
        self.coordinate = CLLocationCoordinate2DMake(latitude,longitude);
        
    }
    return self;
}


@end
