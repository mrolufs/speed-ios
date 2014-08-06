//
//  TPProduct.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 8/5/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "TPProduct.h"

@implementation TPProduct

- (instancetype)initWithJSONObject:(NSDictionary *)json
{
    self = [super init];
    if (self)
    {
        self.title = [json valueForKey:@"title"];
        self.detail = [json valueForKey:@"details"];
        self.fullsizeurl = [json valueForKey:@"fullsizeurl"];
        self.thumbnailurl = [json valueForKey:@"thumbnailurl"];
        self.weburl = [json valueForKey:@"weburl"];
    }
    return self;
}

-(BOOL)fieldExists:(NSString*)searchKey inKeySet:(NSArray*)keySet
{
    for (NSString *key in keySet) {
        if ([searchKey isEqualToString:key])
            return YES;
    }
    return NO;
}

@end
