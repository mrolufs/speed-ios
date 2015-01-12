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
