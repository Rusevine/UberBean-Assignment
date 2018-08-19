//
//  NetworkManager.m
//  UberBean
//
//  Created by Wiljay Flores on 2018-08-18.
//  Copyright © 2018 wiljay. All rights reserved.
//

#import "NetworkManager.h"
#import "Cafe.h"

@interface NetworkManager ()


@end


@implementation NetworkManager

+ (void)getCoffee:(CLLocation*)location andCompletion:(void (^)(NSArray *))completion{
    float latitude = location.coordinate.latitude;
    float longitude = location.coordinate.longitude;
    
    NSString *urlstring = [NSString stringWithFormat:@"https://api.yelp.com/v3/businesses/search?term=cafe&latitude=%f&longitude=%f",latitude,longitude];
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *request =    [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"Bearer USgBOZYgNF5NPcF8TfI3i09WtVAcRuxdNKGyM0_c_oXpfNY2fv4n1jpYS7jTdnmDMjwNDIe_Sma4iOoSiRrqbd6SpSvAreuMfL3tCyeiTvggUeJAyoKYmf-MwrR4W3Yx" forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error != nil) {
            NSLog(@"Error making request: %@", error.localizedDescription);
            abort();
        }
        
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode < 200 || statusCode >= 300) {
            NSLog(@"Non-OK error code: %@", response);
            abort();
        }
        
        NSError *jsonError = nil;
        NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError != nil) {
            NSLog(@"Error parsing JSON: %@", jsonError.localizedDescription);
            abort();
        }
        
        NSArray *coffeeShops = info[@"businesses"];
        NSMutableArray *businesses = [@[] mutableCopy];
        for(NSDictionary *business in coffeeShops){
            Cafe *cafe = [[Cafe alloc] initWithShop:business];
           // CoffeeAnnotation *annotation = [[CoffeeAnnotation alloc] initWithCoordinate:cafe.coordinate];
            [businesses addObject:cafe];
        }
        completion(businesses);
    }];
    [task resume];
}

@end
