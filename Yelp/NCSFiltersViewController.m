//
//  NCSFiltersViewController.m
//  Yelp
//
//  Created by Nathan Speller on 3/21/14.
//  Copyright (c) 2014 Nathan Speller. All rights reserved.
//

#import "NCSFiltersViewController.h"

@interface NCSFiltersViewController ()
@property (nonatomic, strong) NSMutableArray *categories;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation NCSFiltersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Filters";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.categories = [NSMutableArray arrayWithObjects:
      @{
        @"name":@"Price",
        @"type":@"segmented",
        @"list":@[@"$",@"$$",@"$$$",@"$$$$"]
        },
      @{
        @"name":@"Most Popular",
        @"type":@"switches",
        @"list":@[@"Open Now",@"Hot & New",@"Offering a Deal",@"Delivery"]
        },
      @{
        @"name":@"Distance",
        @"type":@"expandable",
        @"list":@[@"Auto",@"2 blocks",@"6 blocks",@"1 mile",@"5 miles"]
        },
      @{
        @"name":@"Sort By",
        @"type":@"expandable",
        @"list":@[@"Best Match",@"Distance",@"Rating",@"Most Reviewed"]
        },
      @{
        @"name":@"General Features",
        @"type":@"expandable",
        @"list":@[@"Take-out",@"Good for Groups",@"Has TV",@"Accepts Credit Cards",@"Wheelchair Accessible",@"Full Bar",@"Beer & Wine only",@"Happy Hour",@"Free Wi-Fi",@"Paid Wi-fi"]
        },
       nil
       ];
    [self.tableView reloadData];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *catArray = self.categories[section][@"list"];
    return catArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.categories[section][@"name"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.delegate addFiltersViewController:self didFinishWithOptions:@"bacon"];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
////    return [NCSRestaurantCell heightForRestaurant:[self.restaurants objectAtIndex:indexPath.row]];
//}

@end
