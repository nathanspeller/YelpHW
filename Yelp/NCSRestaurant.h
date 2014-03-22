//
//  NCSRestaurant.h
//  Yelp
//
//  Created by Nathan Speller on 3/21/14.
//  Copyright (c) 2014 Nathan Speller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCSRestaurant : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *reviews;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSURL *ratingImageURL;
@property (nonatomic, strong) NSURL *imageURL;

- (NCSRestaurant *)initWithDictionary:(NSDictionary *)mDictionary;
- (NSString *)categoriesList;

@end
