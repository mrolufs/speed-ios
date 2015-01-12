//
//  GenerateManager.h
//  ProfileDesign
//
//  Created by Matthew Rolufs on 10/10/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@class Product;

@interface GenerateManager : NSObject

@property (nonatomic) BOOL  isT1Plus;
@property (nonatomic) BOOL  isT2Plus;
@property (nonatomic) BOOL  isT3Plus;
@property (nonatomic) BOOL  isT4Plus;
@property (nonatomic) BOOL  isT1Carbon;
@property (nonatomic) BOOL  isT2Carbon;
@property (nonatomic) BOOL  isT3Carbon;
@property (nonatomic) BOOL  isT4Carbon;
@property (nonatomic) BOOL  isAeria;
@property (nonatomic) BOOL  isZBS;
@property (nonatomic) BOOL  showAeriaConfigs;

/**
 *  Singleton instance of Generate Manager
 *
 *  @return Instance of GenerateManager
 */
+ (instancetype)sharedGenerateManager;

/**
 *  Method to generate Core Data product filter
 *
 *  @param productList NSArray of pre-filtered product items
 *
 *  @return A simple array of product names
 */
- (NSSet *)generateProducts:(NSArray *)productList;

/**
 *  Method to generate product options for display
 *
 *  @param product Product object
 *
 *  @return An array of product options to append to product description
 */
- (NSArray *) generateOptions:(Product *)product;

@end
