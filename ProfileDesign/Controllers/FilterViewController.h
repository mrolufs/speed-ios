//
//  FilterViewController.h
//  ProfileDesign
//
//  Created by Lawrence Leach on 6/8/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *familyList;
@property (nonatomic, strong) NSMutableArray *productList;
@property (nonatomic, assign) NSInteger stack;
@property (nonatomic, assign) NSInteger reach;

@end
