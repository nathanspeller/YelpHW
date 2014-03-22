//
//  NCSRestaurantCell.h
//  Yelp
//
//  Created by Nathan Speller on 3/20/14.
//  Copyright (c) 2014 Nathan Speller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCSRestaurant.h"

@interface NCSRestaurantCell : UITableViewCell

- (void)setRestaurant:(NCSRestaurant *)restaurant;

+ (CGFloat)heightForRestaurant:(NCSRestaurant *)restaurant;
@end
