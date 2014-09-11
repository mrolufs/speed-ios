//
//  ResultsViewController.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 6/16/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "ResultsViewController.h"
#import "Constants.h"
#import "TPProduct.h"
#import "TPProductCell.h"
#import "PDProducts.h"
#import "PDDataManager.h"

@interface ResultsViewController ()
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *products;

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
    [self.tableView registerNib:[UINib nibWithNibName:@"TPProductCell" bundle:nil] forCellReuseIdentifier:@"ProductCell"];
    [self.tableView setRowHeight:110.0f];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    self.products = [self.dm fetchAllProducts];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

-(IBAction)goBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"ProductCell";
    TPProductCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(TPProductCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    long row = indexPath.row;
    
    PDProducts *product = (PDProducts*)[self.products objectAtIndex:row];
    cell.item = product;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    long row = indexPath.row;
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    PDProducts *product = (PDProducts*)[self.products objectAtIndex:row];
    NSString *urlString = [self cleanUpProductPath:product];
    NSURL *url = [NSURL URLWithString:urlString];
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"%@%@",@"Failed to open url: ",[url description]);
    }
}


#pragma mark - Data Cleanup Method

- (NSString*)cleanUpProductPath:(PDProducts*)item
{
    NSString *retStr = @"";
    NSString *path = item.productPath;
    
    if ([path length]>0)
    {
        if ([path isEqualToString:@"CARBON_AEROBARS_PATH"])
        {
            retStr = [NSString stringWithFormat:@"%@%@%@",PRODUCT_PATH,CARBON_AEROBARS_PATH,item.productFile];
        }
        else if ([path isEqualToString:@"ALUMINUM_AEROBARS_PATH"])
        {
            retStr = [NSString stringWithFormat:@"%@%@%@",PRODUCT_PATH,ALUMINUM_AEROBARS_PATH,item.productFile];
        }
    }
    return retStr;
}


@end
