//
//  NCSRestaurant.m
//  Yelp
//
//  Created by Nathan Speller on 3/21/14.
//  Copyright (c) 2014 Nathan Speller. All rights reserved.
//

#import "NCSRestaurant.h"

@implementation NCSRestaurant

- (NCSRestaurant *)initWithDictionary:(NSDictionary *)mDictionary{
    self.name = mDictionary[@"name"];
    self.address = mDictionary[@"location"][@"cross_streets"];
    self.reviews = mDictionary[@"review_count"];
    self.categories = [[NSMutableArray alloc] init];
    self.imageURL  = [NSURL URLWithString:mDictionary[@"image_url"]];
    self.ratingImageURL = [NSURL URLWithString:mDictionary[@"rating_img_url_large"]];
    for (NSArray *category in mDictionary[@"categories"]){
        [self.categories addObject:(NSString *)category[0]];
    }
    return self;
}

- (NSString *)categoriesList{
    return [self.categories componentsJoinedByString:@", "];
}

@end
