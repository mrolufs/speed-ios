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

@interface ResultsViewController ()
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *products;
@end

@implementation ResultsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // SETUP TABLEVIEW
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"TPProductCell" bundle:nil] forCellReuseIdentifier:@"ProductCell"];
    [self.tableView setRowHeight:110.0f];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    [self jsonLoad];
}

-(void)jsonLoad
{
    self.products = [[NSMutableArray alloc] init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:TPLUS_PRODUCTS_JSON ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    for (id itm in json) {
        //NSLog(@"json itm is %@", itm);
        TPProduct *sObj = [[TPProduct alloc] initWithJSONObject:itm];
        [self.products addObject:sObj];
    }
    
    // REFRESH THE TABLEVIEW
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
    
    TPProduct *product = (TPProduct*)[self.products objectAtIndex:row];
    cell.item = product;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    long row = indexPath.row;
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    TPProduct *product = (TPProduct*)[self.products objectAtIndex:row];
    NSString *urlString = product.weburl;
    NSURL *url = [NSURL URLWithString:urlString];
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"%@%@",@"Failed to open url: ",[url description]);
    }
}


@end
