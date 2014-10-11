//
//  Aeria.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 10/6/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "T4Carbon.h"

@implementation T4Carbon



- (id)initWithProduct:(Product *)product
{
    
    self = [super init];
    if (self)
    {
        self.product = product;
    }
    return self;
}

- (NSString*)getDescription
{
    return @"T4+ Carbon";
}

@end
