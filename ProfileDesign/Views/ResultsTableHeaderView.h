//
//  ResultsTableHeaderView.h
//  ProfileDesign
//
//  Created by Lawrence Leach on 9/27/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsTableHeaderView : UIView

@property (nonatomic, weak) IBOutlet UILabel *stackLabel;
@property (nonatomic, weak) IBOutlet UILabel *reachLabel;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) NSDictionary *items;

+ (instancetype)newViewWithFrame:(CGRect)frame;

@end
