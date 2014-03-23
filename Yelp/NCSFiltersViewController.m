//
//  NCSFiltersViewController.m
//  Yelp
//
//  Created by Nathan Speller on 3/21/14.
//  Copyright (c) 2014 Nathan Speller. All rights reserved.
//

#import "NCSFiltersViewController.h"

//enum FilterCategoryListTypes {
//    kTypeSegmented,
//    kTypeSwitches,
//    kTypeExpandable
//};
//
//typedef enum FilterCategoryListTypes FilterCategoryListTypes;

@interface NCSFiltersViewController ()
@property (nonatomic, strong) NSMutableArray *categories;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *isExpanded;
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
    self.isExpanded = [[NSMutableDictionary alloc] initWithCapacity:4];
    
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
    NSDictionary *category = self.categories[section];
    NSArray *catArray = category[@"list"];
    if ([category[@"type"] isEqualToString:@"expandable"]) {
        if ([category[@"type"] isEqualToString:@"expandable"]) {
            if ([self.isExpanded[category[@"name"]] isEqualToValue:@NO]) {
                return catArray.count;
            } else {
                return 1;
            }
        }
    }
    return catArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *category = self.categories[indexPath.section];
    if ([category[@"type"] isEqualToString:@"expandable"]) {
        if ([self.isExpanded[category[@"name"]] isEqualToValue:@NO]) {
            self.isExpanded[category[@"name"]] = @YES;
        } else {
            self.isExpanded[category[@"name"]] = @NO;
        }
        NSLog(@"%@", self.isExpanded);
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.categories[section][@"name"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *category = self.categories[indexPath.section];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if ([category[@"type"] isEqualToString:@"expandable"]) {
        cell.textLabel.text = category[@"list"][indexPath.row];
    }
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.delegate addFiltersViewController:self didFinishWithOptions:@"bacon"];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
////    return [NCSRestaurantCell heightForRestaurant:[self.restaurants objectAtIndex:indexPath.row]];
//}

@end
