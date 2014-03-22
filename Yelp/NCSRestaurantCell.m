//
//  NCSRestaurantCell.m
//  Yelp
//
//  Created by Nathan Speller on 3/20/14.
//  Copyright (c) 2014 Nathan Speller. All rights reserved.
//

#import "NCSRestaurantCell.h"
#import <UIImageView+AFNetworking.h>

@interface NCSRestaurantCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIImageView *rating;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *reviews;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *categories;
@end

@implementation NCSRestaurantCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRestaurant:(NCSRestaurant *)restaurant {
    _restaurant = restaurant;
    self.name.text = self.restaurant.name;
    self.address.text = self.restaurant.address;
    self.categories.text = self.restaurant.categoriesList;
    self.reviews.text = [NSString stringWithFormat:@"%@ reviews", self.restaurant.reviews];
    [self.image setImageWithURL:self.restaurant.imageURL];
    [self.rating setImageWithURL:self.restaurant.ratingImageURL];
//    self.synopsisLabel.text = self.movie.cast;
//    self.ratingLabel.text = [NSString stringWithFormat:@"%d%%", self.movie.criticScore];
//    
//    [self.posterView setImageWithURL:[NSURL URLWithString:self.movie.imageOriginalLink]];
}

@end
