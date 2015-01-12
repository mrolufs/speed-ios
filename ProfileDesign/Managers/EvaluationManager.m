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
#import "F19.h"
#import "F25.h"
#import "F35.h"
#import "Flipped.h"
#import "J2.h"
#import "J4.h"
#import "PosFront.h"
#import "PosMiddle.h"
#import "PosRear.h"
#import "T1Carbon.h"
#import "T1Plus.h"
#import "T2Carbon.h"
#import "T2Plus.h"
#import "T3Carbon.h"
#import "T3Plus.h"
#import "T4Carbon.h"
#import "T4Plus.h"
#import "ZBS.h"


@implementation EvaluationManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static EvaluationManager * sharedInstance;
    dispatch_once(&onceToken, ^(void)
                  {
                      sharedInstance = [[EvaluationManager alloc] init];
                  });
    
    return sharedInstance;
}

- (void)addToList:(NSArray *)items
{
    for (NSString *item in items)
    {
        if (![self.tFamilyList containsObject:item])
        {
            [self.tFamilyList addObject:item];
        }
    }
}

- (void)evaluateWithStack:(NSInteger)stack
                withReach:(NSInteger)reach
           withCompletion:(void (^)(NSArray *familyObjects, NSArray *productObjects))completionBlock
{
    self.tFamilyList = [[NSMutableArray alloc] init];
    self.productList = [[NSMutableArray alloc] init];

    if ((reach >= -55 && reach < -40) && (stack >= 50 && stack < 140))
    {
        [self addToList:@[@"T2", @"T4"]];
        
        [self.productList addObject:[[Aeria alloc] initWithProduct:[[T2Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[Product alloc] init]]]]]];
        
        [self.productList addObject:[[Aeria alloc] initWithProduct:[[T4Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[Product alloc] init]]]]]];
    }
    
    if ((reach >= -35 && reach < -20) && (stack >= 50 && stack < 140))
    {
        [self addToList:@[@"T2", @"T4"]];
        
        [self.productList addObject:[[Aeria alloc] initWithProduct:[[T2Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[Aeria alloc] initWithProduct:[[T4Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Product alloc] init]]]]]];
    }
    
    if ((reach >= -40 && reach < -35) && (stack >= 50 && stack < 140))
    {
        [self addToList:@[@"T2", @"T4"]];
        
        [self.productList addObject:[[Aeria alloc] initWithProduct:[[T2Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosRear alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[Product alloc] init]]]]]]];
        [self.productList addObject:[[Aeria alloc] initWithProduct:[[T4Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosRear alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[Product alloc] init]]]]]]];
    }
    
    if ((reach >= -20  && reach < -5) && (stack >= 50 && stack < 140))
    {
        [self addToList:@[@"T2", @"T4"]];
        
        [self.productList addObject:[[Aeria alloc] initWithProduct:[[T2Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[Product alloc] init]]]]]]];
        [self.productList addObject:[[Aeria alloc] initWithProduct:[[T4Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[Product alloc] init]]]]]]];
    }
    
    if ((reach >= 0  && reach < 15) && (stack >= 50 && stack < 140))
    {
        [self addToList:@[@"T2", @"T4"]];
        
        [self.productList addObject:[[Aeria alloc] initWithProduct:[[T2Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[Product alloc] init]]]]]]];
        [self.productList addObject:[[Aeria alloc] initWithProduct:[[T4Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[Product alloc] init]]]]]]];
    }
    
    if ((reach >= -95 && reach < -80) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T1", @"T2", @"T3", @"T4"]];
        
        [self.productList addObject:[[T1Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosRear alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T2Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosRear alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T3Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosRear alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T4Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosRear alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
    }
    
    if ((reach >= -85 && reach < -70) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T1", @"T2", @"T3", @"T4"]];
        
        [self.productList addObject:[[T1Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosRear alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T2Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosRear alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T3Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosRear alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T4Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosRear alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
    }
    
    if ((reach >= -80 && reach < -65) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T1", @"T2", @"T3", @"T4"]];
        
        [self.productList addObject:[[T1Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T2Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T3Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T4Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
    }
    
    if ((reach >= -65 && reach < -50) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T1", @"T2", @"T3", @"T4"]];
        
        [self.productList addObject:[[T1Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T2Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T3Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T4Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
    }
    
    if ((reach >= -65 && reach < -50) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T1", @"T2", @"T3", @"T4"]];
        
        [self.productList addObject:[[T1Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]];
        [self.productList addObject:[[T2Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]];
        [self.productList addObject:[[T3Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]];
        [self.productList addObject:[[T4Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]];
    }
    
    if ((reach >= -45 && reach < -30) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T1", @"T2", @"T3", @"T4"]];
        
        [self.productList addObject:[[T1Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T2Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T3Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T4Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
    }
    
    if ((reach >= -50 && reach < -35) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T1", @"T2", @"T3", @"T4"]];
        
        [self.productList addObject:[[T1Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T2Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T3Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
        [self.productList addObject:[[T4Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]];
    }
    
    if ((reach >= -30 && reach < -15) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T1", @"T2", @"T3", @"T4"]];
        
        [self.productList addObject:[[T1Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]];
        [self.productList addObject:[[T2Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]];
        [self.productList addObject:[[T3Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]];
        [self.productList addObject:[[T4Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]];
    }
    
    if ((reach >= -30 && reach < -15) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T1", @"T2", @"T3", @"T4"]];
        
        [self.productList addObject:[[T1Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]]];
        [self.productList addObject:[[T2Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]]];
        [self.productList addObject:[[T3Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]]];
        [self.productList addObject:[[T4Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]]];
    }
    
    if ((reach >= -10 && reach < 5) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T1", @"T2", @"T3", @"T4"]];
        
        [self.productList addObject:[[T1Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]];
        [self.productList addObject:[[T2Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]];
        [self.productList addObject:[[T3Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]];
        [self.productList addObject:[[T4Carbon alloc] initWithProduct:[[F35 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]];
    }
    
    if ((reach >= -15 && reach < 0) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T1", @"T2", @"T3", @"T4"]];
        
        [self.productList addObject:[[T1Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]];
        [self.productList addObject:[[T2Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]];
        [self.productList addObject:[[T3Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]];
        [self.productList addObject:[[T4Carbon alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Flipped alloc] initWithProduct:[[J4 alloc] initWithProduct:[[Product alloc] init]]]]]]];
    }
    
    if (((reach >= -185 && reach < 5) || (reach >= 15 && reach < 90)) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T1"]];

        [self.productList addObject:[[T1Plus alloc] initWithProduct:[[F19 alloc] initWithProduct:[[J2 alloc] initWithProduct:[[Product alloc] init]]]]];
    }
    
    if (((reach >= -170 && reach < 5) || (reach >= 15 && reach < 90)) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T1"]];
        
        [self.productList addObject:[[T1Plus alloc] initWithProduct:[[F35 alloc] initWithProduct:[[J2 alloc] initWithProduct:[[Product alloc] init]]]]];
    }
    
    if (((reach >= -165 && reach < 5) || (reach >= 15 && reach < 75)) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T2"]];
        
        [self.productList addObject:[[T2Plus alloc] initWithProduct:[[F19 alloc] initWithProduct:[[J2 alloc] initWithProduct:[[Product alloc] init]]]]];
        
    }
    
    if (((reach >= -165 && reach < 5) || (reach >= 15 && reach < 70)) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T2"]];
        
        [self.productList addObject:[[T2Plus alloc] initWithProduct:[[F35 alloc] initWithProduct:[[J2 alloc] initWithProduct:[[Product alloc] init]]]]];
    }
    
    if (((reach >= -165 && reach < 5) || (reach >= 15 && reach < 80)) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T3"]];
        
        [self.productList addObject:[[T3Plus alloc] initWithProduct:[[F19 alloc] initWithProduct:[[J2 alloc] initWithProduct:[[Product alloc] init]]]]];
    }
    
    if (((reach >= -155 && reach < 5) || (reach >= 15 && reach < 75)) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T3"]];
        
        [self.productList addObject:[[T3Plus alloc] initWithProduct:[[F35 alloc] initWithProduct:[[J2 alloc] initWithProduct:[[Product alloc] init]]]]];
    }
    
    if (((reach >= -165 && reach < 5) || (reach >= 15 && reach < 75)) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T4"]];
        
        [self.productList addObject:[[T4Plus alloc] initWithProduct:[[F19 alloc] initWithProduct:[[J2 alloc] initWithProduct:[[Product alloc] init]]]]];
    }
	
    if (((reach >= -150 && reach < 5) || (reach >= 15 && reach < 75)) && (stack >= 55 && stack < 100))
    {
        [self addToList:@[@"T4"]];
        
        [self.productList addObject:[[T4Plus alloc] initWithProduct:[[F35 alloc] initWithProduct:[[J2 alloc] initWithProduct:[[Product alloc] init]]]]];
    }

    if (((reach >= -100  && reach < -85) && (stack >= 35 && stack < 45)) || ((reach >= -95 && reach < -80) && (stack >= 45 && stack < 55)))
    {
        [self.productList addObject:[[ZBS alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosRear alloc] initWithProduct:[[Product alloc] init]]]]];
    }
    
    if (((reach >= -85  && reach < -70) && (stack >= 35 && stack < 45)) || ((reach >= -80 && reach < -65) && (stack >= 45 && stack < 55)))
    {
        [self.productList addObject:[[ZBS alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosRear alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[Product alloc] init]]]]]];
    }
    
    if (((reach >= -70  && reach < -55) && (stack >= 35 && stack < 45)) || ((reach >= -65 && reach < -50) && (stack >= 45 && stack < 55)))
    {
        [self.productList addObject:[[ZBS alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[PosMiddle alloc] initWithProduct:[[Product alloc] init]]]]]];
    }
    
    if (((reach >= -55  && reach < -40) && (stack >= 35 && stack < 45)) || ((reach >= -50 && reach < -35) && (stack >= 45 && stack < 55)))
    {
         [self.productList addObject:[[ZBS alloc] initWithProduct:[[F19 alloc] initWithProduct:[[PosFront alloc] initWithProduct:[[Product alloc] init]]]]];
    }

    if (self.tFamilyList.count > 2)
    {
        NSLog(@"MORE THAN 2 T Family Items!!!");
    }
    
    if (completionBlock)
    {
        completionBlock(self.tFamilyList, self.productList);
    };
}

@end
