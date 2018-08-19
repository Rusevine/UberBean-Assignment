//
//  NetworkManager.h
//  UberBean
//
//  Created by Wiljay Flores on 2018-08-18.
//  Copyright © 2018 wiljay. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface NetworkManager : NSObject



+(void)getCoffee:(CLLocation*)location andCompletion:(void (^)(NSArray *))completion;

@end
