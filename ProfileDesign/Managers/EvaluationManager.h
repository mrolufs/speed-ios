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
- (void)evaluateWithStack:(NSInteger)stack withReach:(NSInteger)reach withCompletion:(void (^)(NSArray *familyObjects, NSArray *productObjects))completionBlock;

@end
