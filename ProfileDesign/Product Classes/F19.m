//
//  Aeria.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 10/6/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "F19.h"

@implementation F19



- (id)initWithProduct:(Product *)product
{
    
    self = [super init];
    if (self)
    {
        self.product = product;
    }
    return self;
}

- (NSString*)description
{
    return @"F19 Armrest";
}

@end
