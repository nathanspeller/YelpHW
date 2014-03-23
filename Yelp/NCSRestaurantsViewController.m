//
//  NCSRestaurantsViewController.m
//  Yelp
//
//  Created by Nathan Speller on 3/20/14.
//  Copyright (c) 2014 Nathan Speller. All rights reserved.
//

#import "NCSRestaurantsViewController.h"
#import "NCSRestaurantCell.h"
#import "NCSFiltersViewController.h"
#import "NCSYelpClient.h"
#import "NCSRestaurant.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface NCSRestaurantsViewController ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NCSYelpClient *client;
@property (nonatomic, strong) NSMutableArray *restaurants;
@end

@implementation NCSRestaurantsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.client = [[NCSYelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"response: %@", response);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [error description]);
        }];
    }
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 310.0, 44.0)];
    searchBarView.autoresizingMask = 0;
    searchBar.delegate = self;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];
    [searchBarView addSubview:searchBar];
    self.navigationItem.titleView = searchBarView;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.restaurants = [[NSMutableArray alloc] init];
    
    // add the filters button
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filters" style:UIBarButtonItemStylePlain target:self action:@selector(onFilters:)];
    self.navigationItem.leftBarButtonItem = filterButton;
    
    // styles
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.000];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.76 green:0.07 blue:0.0 alpha:1.0];
    
    
    // grab a default query
    [self fetchQuery:@"Thai"];
}

- (void)fetchQuery:(NSString *)query {
    [self.client searchWithTerm:query success:^(AFHTTPRequestOperation *operation, id response) {
        NSDictionary *dataDictionary = (NSDictionary *)response;
        NSArray *businessesArray = [dataDictionary objectForKey:@"businesses"];
        [self.restaurants removeAllObjects];
        for (NSDictionary *mDictionary in businessesArray) {
            NCSRestaurant *restaurant = [[NCSRestaurant alloc] initWithDictionary:mDictionary];
            [self.restaurants addObject:restaurant];
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (IBAction)onFilters:(id)sender{
    NCSFiltersViewController *vc = [[NCSFiltersViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.restaurants.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // show restaurant view (optional)
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RestaurantCell";
    
    NCSRestaurantCell *cell = (NCSRestaurantCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NCSRestaurantCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NCSRestaurant *restaurant = [self.restaurants objectAtIndex:indexPath.row];
    [cell setRestaurant:restaurant];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NCSRestaurantCell heightForRestaurant:[self.restaurants objectAtIndex:indexPath.row]];
}

#pragma mark - Search methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];
}

- (void)handleSearch:(UISearchBar *)searchBar {
    [self fetchQuery:searchBar.text];
    [self.tableView reloadData];
    [searchBar resignFirstResponder]; // for hiding the keyboard
}

#pragma mark - Filter methods

- (void)addFiltersViewController:(NCSFiltersViewController *)controller didFinishWithOptions:(NSString *)options
{
    [self fetchQuery:options];
    [self.tableView reloadData];
}

@end
