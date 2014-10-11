//
//  Aeria.h
//  ProfileDesign
//
//  Created by Lawrence Leach on 10/6/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface PosMiddle : Product

@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) Product *product;

- (id)initWithProduct:(Product *)product;

@end
