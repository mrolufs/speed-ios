//
//  Product.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 10/6/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "Product.h"

@interface Product ()
@property (nonatomic, strong) Product *product;
@end

@implementation Product

- (id) init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (id) initWithProduct:(Product *)product
{
    self = [super init];
    if (self)
    {
        self.product = product;
    }
    return self;
}

- (NSString *)getDescription
{
    return @"Product";
}

//- (NSString *)description
//{
//    return @"Product";
//}

- (Product *)getProduct
{
    return self.product;
}

@end
