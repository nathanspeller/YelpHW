//
//  NCSRestaurantCell.m
//  Yelp
//
//  Created by Nathan Speller on 3/20/14.
//  Copyright (c) 2014 Nathan Speller. All rights reserved.
//

#import "NCSRestaurantCell.h"
#import <UIImageView+AFNetworking.h>
#import <QuartzCore/QuartzCore.h>

@interface NCSRestaurantCell ()
@property (nonatomic, strong) NCSRestaurant *restaurant;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIImageView *rating;
@property (weak, nonatomic) IBOutlet UILabel *reviews;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *categories;
@end

@implementation NCSRestaurantCell

+ (CGFloat)heightForRestaurant:(NCSRestaurant *)restaurant cell:(NCSRestaurantCell *)prototype{
    // TODO should get attributes of name UILabel prototype rather than hardcoded
    CGFloat nameWidth = prototype.name.frame.size.width;
    UIFont *font = prototype.name.font;
    
//    // NEED TO SOMEHOW ROTATE THE PROTOTYPE
//    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
//    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight){
//        nameWidth = 340;
//    }
    
    CGSize constrainedSize = CGSizeMake( nameWidth, 9999);
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                         font, NSFontAttributeName, nil];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:restaurant.name attributes:attributesDictionary];
    
    CGRect requiredHeight = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    return 80+requiredHeight.size.height;
}

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
    self.image.layer.masksToBounds = YES;
    self.image.layer.cornerRadius = 5.0f;
    [self.rating setImageWithURL:self.restaurant.ratingImageURL];
}

@end
