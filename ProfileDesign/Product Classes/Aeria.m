//
//  Aeria.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 10/6/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "Aeria.h"

@implementation Aeria

- (id)initWithProduct:(Product *)theProduct
{
    self = [super init];
    if (self)
    {
        self.product = theProduct;
    }
    return self;
}

- (NSString *)description
{
    return @"Aeria";
}

- (NSString *)getDescription
{
    return self.description;
}

@end
