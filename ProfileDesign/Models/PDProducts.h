//
//  PDProducts.h
//  ProfileDesign
//
//  Created by Lawrence Leach on 9/10/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface PDProducts : NSManagedObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *productPath;
@property (nonatomic, retain) NSString *imageFile;
@property (nonatomic, retain) NSString *details;
@property (nonatomic, retain) NSString *color;
@property (nonatomic, retain) NSString *material;
@property (nonatomic, retain) NSString *armrest;
@property (nonatomic, retain) NSString *armrestMaterial;
@property (nonatomic, retain) NSString *weight;
@property (nonatomic, retain) NSString *productFile;

@end
