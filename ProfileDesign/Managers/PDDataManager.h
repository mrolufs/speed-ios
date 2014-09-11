//
//  PDDataManager.h
//  ProfileDesign
//
//  Created by Lawrence Leach on 9/10/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface PDDataManager : NSObject

+ (instancetype)sharedInstance;
- (NSArray*)fetchAllProducts;
- (void)loadDataAsInitial:(BOOL)initial withCompletion:(completionBlock)completion;

@end
