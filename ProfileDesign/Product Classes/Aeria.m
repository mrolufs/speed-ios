//
//  Aeria.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 10/6/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "Aeria.h"

@implementation Aeria

- (id)initWithProduct:(Product *)product
{
    self = [super init];
    if (self)
    {
        self.product = product;
    }
    return self;
}

- (void)setDescription:(NSString *)description
{
    _description = description;
}

@end
