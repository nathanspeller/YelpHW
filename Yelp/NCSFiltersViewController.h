//
//  NCSFiltersViewController.h
//  Yelp
//
//  Created by Nathan Speller on 3/21/14.
//  Copyright (c) 2014 Nathan Speller. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NCSFiltersViewController;
@protocol NCSFiltersViewControllerDelegate <NSObject>
- (void)addFiltersViewController:(NCSFiltersViewController *)controller didFinishWithOptions:(NSString *)options;
@end

@interface NCSFiltersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) id <NCSFiltersViewControllerDelegate> delegate;
@end
