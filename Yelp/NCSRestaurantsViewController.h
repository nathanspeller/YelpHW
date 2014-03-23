//
//  NCSRestaurantsViewController.h
//  Yelp
//
//  Created by Nathan Speller on 3/20/14.
//  Copyright (c) 2014 Nathan Speller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCSFiltersViewController.h"

@interface NCSRestaurantsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, NCSFiltersViewControllerDelegate>
@end
