//
//  Aeria.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 10/6/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "J2.h"


@implementation J2

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
    return @"J2 Bracket";
}

@end
