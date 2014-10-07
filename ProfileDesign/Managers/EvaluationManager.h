//
//  EvaluationManager.h
//  ProfileDesign
//
//  Created by Lawrence Leach on 10/6/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluationManager : NSObject

@property (nonatomic, strong) NSMutableArray *productList;
@property (nonatomic, strong) NSMutableArray *tFamilyList;
@property (nonatomic, strong) NSString *familyItem;

+ (instancetype)sharedInstance;
- (void)evaluateStack:(NSInteger)stack andReach:(NSInteger)reach;

@end
