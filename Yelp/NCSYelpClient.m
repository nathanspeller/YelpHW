//
//  NCSYelpClient.m
//  Yelp
//
//  Created by Nathan Speller on 3/21/14.
//  Copyright (c) 2014 Nathan Speller. All rights reserved.
//

#import "NCSYelpClient.h"

@implementation NCSYelpClient

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:accessToken secret:accessSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSDictionary *parameters = @{@"term": term, @"location" : @"San Francisco"};
    
    return [self GET:@"search" parameters:parameters success:success failure:failure];
}

- (AFHTTPRequestOperation *)searchWithOptions:(NSString *)term options:(NSDictionary *)options success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSMutableDictionary *parameters = [@{@"term": term, @"location" : @"San Francisco"} mutableCopy];
    
    if (options[@"Offering a Deal"]) {
        parameters[@"deals_filter"] = @(YES);
    }
    
    
    if (options[@"Sort By"]){
        if ([options[@"Sort By"]  isEqual: @"Best Match"]) {
            parameters[@"sort"] = @"0";
        } else if ([options[@"Sort By"]  isEqual: @"Distance"]) {
            parameters[@"sort"] = @"1";
        } else if ([options[@"Sort By"]  isEqual: @"Rating"]) {
            parameters[@"sort"] = @"2";
        }
    }
    
    if (options[@"Distance"]) {
        if ([options[@"Distance"]  isEqual: @"2 blocks"]) {
            parameters[@"radius_filter"] = @"100";
        } else if ([options[@"Distance"]  isEqual: @"6 blocks"]) {
            parameters[@"radius_filter"] = @"300";
        } else if ([options[@"Distance"]  isEqual: @"1 mile"]) {
            parameters[@"radius_filter"] = @"1609";
        } else if ([options[@"Distance"]  isEqual: @"5 miles"]) {
            parameters[@"radius_filter"] = @"8046";
        }
    }
    
    NSMutableArray *categories = [[NSMutableArray alloc] init];
    
    if (options[@"Barbeque"]) {
        [categories addObject:@"bbq"];
    }
    if (options[@"Brazilian"]) {
        [categories addObject:@"brazilian"];
    }
    if (options[@"Brunch"]) {
        [categories addObject:@"breakfast_brunch"];
    }
    if (options[@"British"]) {
        [categories addObject:@"british"];
    }
    if (options[@"Burgers"]) {
        [categories addObject:@"burgers"];
    }
    if (options[@"Cafes"]) {
        [categories addObject:@"cafes"];
    }
    if (options[@"Cambodian"]) {
        [categories addObject:@"cambodian"];
    }
    if (options[@"Chinese"]) {
        [categories addObject:@"chinese"];
    }
    if (options[@"Chicken Wings"]) {
        [categories addObject:@"chicken_wings"];
    }
    
    if (categories.count){
        parameters[@"category_filter"] = [categories componentsJoinedByString:@","];
    }
    
    return [self GET:@"search" parameters:parameters success:success failure:failure];
}

@end
