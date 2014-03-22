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
@property (nonatomic, strong) NCSRestaurantCell *prototypeCell;
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
        self.prototypeCell = [[NCSRestaurantCell alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Yelp";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.restaurants = [[NSMutableArray alloc] init];
    
    [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
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
    
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filters" style:UIBarButtonItemStylePlain target:self action:@selector(onFilters:)];
    self.navigationItem.leftBarButtonItem = filterButton;
}

- (IBAction)onFilters:(id)sender{
    NCSFiltersViewController *vc = [[NCSFiltersViewController alloc] init];
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
    return [self.prototypeCell heightForRestaurant:[self.restaurants objectAtIndex:indexPath.row]];
}

@end
