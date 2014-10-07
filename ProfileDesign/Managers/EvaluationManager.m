//
//  EvaluationManager.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 10/6/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "EvaluationManager.h"
#import "Aeria.h"
#import "Product.h"

@implementation EvaluationManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static EvaluationManager *sharedInstance;
    dispatch_once(&onceToken, ^(void)
                  {
                      sharedInstance = [[EvaluationManager alloc] init];
                  });
    return sharedInstance;

}

- (void)addToList:(NSArray *)items
{
    for (NSString *item in items) {
        if (![self.tFamilyList containsObject:item])
        {
            [self.tFamilyList addObject:item];
        }
    }
}

- (void)evaluateStack:(NSInteger)stack andReach:(NSInteger)reach
{
    self.tFamilyList = [[NSMutableArray alloc] init];
    
    if ((reach >= -75 && reach < -60) && (stack >= 50 && stack < 140))
    {
        [self addToList:@[@"T2",@"T4"]];
        
        Product *product = [[Product alloc] init];
        Product *aeria = [[Aeria alloc] initWithProduct:product];
        [self.productList addObject:aeria];
    }
    
    
}

@end
