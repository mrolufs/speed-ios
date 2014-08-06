//
//  TPProduct.h
//  ProfileDesign
//
//  Created by Lawrence Leach on 8/5/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPProduct : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *fullsizeurl;
@property (nonatomic, copy) NSString *thumbnailurl;
@property (nonatomic, copy) NSString *weburl;

- (instancetype)initWithJSONObject:(NSDictionary *)json;

@end
