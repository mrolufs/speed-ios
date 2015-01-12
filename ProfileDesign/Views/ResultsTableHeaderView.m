//
//  ResultsTableHeaderView.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 9/27/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "ResultsTableHeaderView.h"


@implementation ResultsTableHeaderView

+ (instancetype)newViewWithFrame:(CGRect)frame
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ResultsTableHeaderView class]) owner:self options:nil];
    ResultsTableHeaderView *view = [nibViews objectAtIndex:0];
    view.frame = frame;
    
    return view;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setItems:(NSDictionary *)items
{
    _items = items;
    
    NSString *product = [_items valueForKey:@"product"];
    NSString *productString = [NSString stringWithFormat:@"%@ Stack/Reach:", product];
    NSString *stack = [_items valueForKey:@"stack"];
    NSString *reach = [_items valueForKey:@"reach"];
    
    self.titleLabel.text = productString;
    self.stackLabel.text = stack;
    self.reachLabel.text = reach;
}

@end
