//
//  ResultsViewController.h
//  ProfileDesign
//
//  Created by Lawrence Leach on 6/16/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *filteredProductList;
@property (nonatomic, assign) NSInteger stack;
@property (nonatomic, assign) NSInteger reach;

@end


@interface ConfigCell3Item : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* configCell_3Item_1;
@property (weak, nonatomic) IBOutlet UILabel* configCell_3Item_2;
@property (weak, nonatomic) IBOutlet UILabel* configCell_3Item_3;

@end

@interface ConfigCell4Item : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* configCell_4Item_1;
@property (weak, nonatomic) IBOutlet UILabel* configCell_4Item_2;
@property (weak, nonatomic) IBOutlet UILabel* configCell_4Item_3;
@property (weak, nonatomic) IBOutlet UILabel* configCell_4Item_4;

@end