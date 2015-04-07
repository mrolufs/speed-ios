//
//  ResultsViewController.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 6/16/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "ResultsViewController.h"
#import "ResultsTableHeaderView.h"
#import "Constants.h"
#import "TPProduct.h"
#import "TPProductCell.h"
#import "PDProducts.h"
#import "PDDataManager.h"
#import "GenerateManager.h"
#import "Product.h"
#import "TempConfig.h"


@implementation ConfigCell3Item

@end

@implementation ConfigCell4Item

@end




@interface ResultsViewController ()
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) NSArray *configurations;

@property (nonatomic, strong) PDDataManager *dm;



@end


@implementation ResultsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // GET THE DATA MANAGER
    self.dm = [PDDataManager sharedInstance];
    
    // SETUP TABLEVIEW
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor blackColor];
    //[self.tableView registerNib:[UINib nibWithNibName:@"TPProductCell" bundle:nil] forCellReuseIdentifier:@"ProductCell"];
    [self.tableView setRowHeight:110.0f];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    ResultsTableHeaderView *headerView = [ResultsTableHeaderView newViewWithFrame:CGRectMake(0, 0, 320.0f, 150.0f)];
    headerView.stackLabel.text = [NSString stringWithFormat:@"%ld", (long)self.stack];
    headerView.reachLabel.text = [NSString stringWithFormat:@"%ld", (long)self.reach];
    [self.tableView setTableHeaderView:headerView];
    
    NSLog(@"\n\nFiltered Product List: \n%@", self.filteredProductList);
    
//    [self.filteredProductList enumerateObjectsUsingBlock:^(Product *obj, NSUInteger idx, BOOL *stop)
//    {
//        NSLog(@"\nObject: %@", obj);
//    }];

    // GENERATE PRODUCT LIST
    NSSet *mySet = [[GenerateManager sharedGenerateManager] generateProducts:self.filteredProductList];
    self.products = [self.dm fetchProductsUsingList:[mySet allObjects]];
    
    //NSSet *myConfigsSet = [[GenerateManager sharedGenerateManager] generateOptions:self.filteredProductList];
    //self.configurations = [self.dm fetchConfigurationsUsingList:[myConfigsSet allObjects]];
    
    // Note: Need different list of configs per product
    // Consider, adding a list of configs to the product model
    // in that case, kill self.confogurations, and pull from product
    // ie, in cellForRowAtIndexPath TempConfig* config = [[self.products objectForIndex:indexPath.section / 2].configs[objectForIndex: indexPath.row];
    // Or, if not, maybe consider making a list of lists of configs, so that you could access like this:
    // TempConfig* config = [self.configuationLists[objectForIndex: indexPath.section] objectForIndex:indexPath.row];
    // Due to nature of obj c, you will want to null check config after trying to pull it from a list
    
    TempConfig* tc1 = [[TempConfig alloc] init];
    tc1.product = @"T2+ Carbon";
    tc1.armrest = @"F35Armrest";
    tc1.position = @"Middle";
    
    TempConfig* tc2 = [[TempConfig alloc] init];
    tc2.product = @"T1+ Carbon";
    tc2.armrest = @"F19 Armrest";
    tc2.position = @"Front";
    tc2.bracket = @"J4";
    
    TempConfig* tc3 = [[TempConfig alloc] init];
    tc1.product = @"T3+ Carbon";
    tc1.armrest = @"F25 Armrest";
    tc1.position = @"Rear";
    
    
    
    self.configurations = [[NSArray alloc] initWithObjects:tc1, tc2, tc3, nil];
    
    //NSLog(@"\n\nConfig List: \n%@", myConfigsSet);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (IBAction)goBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section % 2 == 0) {
        return 400.0f;
    } else {
        return 144.0f;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.products.count * 2;
    // Note: will NOT work if no alt configs, BUT, we can worry about that later
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section % 2 == 0) {
        return 1;
    }
    return self.configurations.count;
    // TODO: modify this to match the way configs are actually stored
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifierProduct = @"ProductCell";
    static NSString * CellIdentifierConfig3 = @"ConfigCell_3Items";
    static NSString * CellIdentifierConfig4 = @"ConfigCell_4Items";
    
    UITableViewCell* cell;
    
    if (indexPath.section % 2 == 0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifierProduct forIndexPath:indexPath];
        [self configureProductCell:(TPProductCell*)cell forRowAtIndexPath:indexPath];
    } else {
        TempConfig* config = [self.configurations objectAtIndex:indexPath.row];
        int fields = 0;
        if (config.product) { fields++; }
        if (config.armrest) { fields++; }
        if (config.position) { fields++; }
        if (config.bracket) { fields++; }
        
        if (fields == 3) {
            cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifierConfig3 forIndexPath:indexPath];
            [self configureConfig3Cell:(ConfigCell3Item*)cell forConfig:config];
        } else {
            cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifierConfig4 forIndexPath:indexPath];
            [self configureConfig4Cell:(ConfigCell4Item*)cell forConfig:config];
        }
    }
    
    return cell;
    
}

- (void)configureProductCell:(TPProductCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    long row = indexPath.row;
    
    PDProducts *product = (PDProducts *)[self.products objectAtIndex:row];
    //cell.item = @{ @"product":product, @"options":self.filteredProductList };
    cell.item = @{ @"product":product, @"options":product };
}

- (void)configureConfig3Cell:(ConfigCell3Item *)cell forConfig:(TempConfig *)config
{
    cell.configCell_3Item_1.text = config.product;
    cell.configCell_3Item_2.text = config.armrest;
    cell.configCell_3Item_3.text = config.position;
}

- (void)configureConfig4Cell:(ConfigCell4Item *)cell forConfig:(TempConfig *)config
{
    cell.configCell_4Item_1.text = config.product;
    cell.configCell_4Item_2.text = config.armrest;
    cell.configCell_4Item_3.text = config.position;
    cell.configCell_4Item_4.text = config.bracket;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    long row = indexPath.row;
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    PDProducts *product = (PDProducts *)[self.products objectAtIndex:row];
    NSString *urlString = [self cleanUpProductPath:product];
    NSURL *url = [NSURL URLWithString:urlString];
    if (![[UIApplication sharedApplication] openURL:url])
    {
        NSLog(@"%@%@", @"Failed to open url: ", [url description]);
    }
}

#pragma mark - Data Cleanup Method

- (NSString *)cleanUpProductPath:(PDProducts *)item
{
    NSString *retStr = @"";
    NSString *path = item.productPath;
    
    if ([path length]>0)
    {
        if ([path isEqualToString:@"CARBON_AEROBARS_PATH"])
        {
            retStr = [NSString stringWithFormat:@"%@%@%@", PRODUCT_PATH, CARBON_AEROBARS_PATH, item.productFile];
        }
        else if ([path isEqualToString:@"ALUMINUM_AEROBARS_PATH"])
        {
            retStr = [NSString stringWithFormat:@"%@%@%@", PRODUCT_PATH, ALUMINUM_AEROBARS_PATH, item.productFile];
        }
    }
    
    return retStr;
}

@end
