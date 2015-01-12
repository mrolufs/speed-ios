//
//  TPProductCell.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 8/5/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "TPProductCell.h"
#import "PDProducts.h"
#import "Constants.h"

// PRODUCTS
#import "Aeria.h"
#import "Product.h"
#import "F19.h"
#import "F25.h"
#import "F35.h"
#import "Flipped.h"
#import "J2.h"
#import "J4.h"
#import "PosFront.h"
#import "PosMiddle.h"
#import "PosRear.h"
#import "T1Carbon.h"
#import "T1Plus.h"
#import "T2Carbon.h"
#import "T2Plus.h"
#import "T3Carbon.h"
#import "T3Plus.h"
#import "T4Carbon.h"
#import "T4Plus.h"
#import "ZBS.h"

@interface TPProductCell ()

@property (nonatomic, weak) IBOutlet UIImageView *thumb;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UITextView *details;
@property (nonatomic, weak) IBOutlet UILabel *colors;
@property (nonatomic, weak) IBOutlet UILabel *material;
@property (nonatomic, weak) IBOutlet UILabel *armrest;
@property (nonatomic, weak) IBOutlet UILabel *armrestMaterial;
@property (nonatomic, weak) IBOutlet UILabel *weight;

@end


@implementation TPProductCell

@synthesize item;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.title setTextColor:[UIColor purpleColor]];
    }
    
    return self;
}

- (void)setItem:(NSDictionary *)newItem
{
    if (newItem != item)
    {
        item = nil;
        item = newItem;
        
        if (item != nil)
        {
            // FIRST, FORMAT THE PRODUCTS
            PDProducts *product = [item valueForKey:@"product"];
            
            self.title.text = product.title;
            self.details.text = product.details;
            self.colors.text = product.color;
            self.material.text = product.material;
            self.armrest.text = product.armrest;
            self.armrestMaterial.text = product.armrestMaterial;
            self.weight.text = product.weight;
            
            NSString *imagePath = [NSString stringWithFormat:@"%@%@", IMAGES_PATH, product.imageFile];
            
            NSURL *imgUrl = [NSURL URLWithString:imagePath];
            NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
            UIImage *img = [UIImage imageWithData:imgData];
            [self.thumb setImage:img];
                        
            //SECOND, FORMAT PRODUCT CONFIGURATIONS / OPTIONS
            //NSArray *options = [item valueForKey:@"options"];
            //[self formatProductOptions:options];
        }
    }
}

- (void)formatProductOptions:(NSArray *)options
{
    __block NSString *fieldData = self.details.text;
    
    [options enumerateObjectsUsingBlock:^(Product *obj, NSUInteger idx, BOOL *stop)
    {
        if ([obj class] == [T1Plus class])
        {
            T1Plus *myObj = (T1Plus *)obj;
            if (myObj.product != nil)
            {
                NSString *theOption = [myObj.product description];
                if ([myObj.description isEqualToString:self.title.text])
                {
                    fieldData = [fieldData stringByAppendingString:[NSString stringWithFormat:@"\n%@", theOption]];
                }
            }
        }
        else if ([obj class] == [T2Plus class])
        {
            T2Plus *myObj = (T2Plus *)obj;
            if (myObj.product != nil)
            {
                NSString *theOption = [myObj.product description];
                if ([myObj.description isEqualToString:self.title.text])
                {
                    fieldData = [fieldData stringByAppendingString:[NSString stringWithFormat:@"\n%@", theOption]];
                }
            }
        }
        else if ([obj class] == [T3Plus class])
        {
            T3Plus *myObj = (T3Plus *)obj;
            if (myObj.product != nil)
            {
                NSString *theOption = [myObj.product description];
                if ([myObj.description isEqualToString:self.title.text])
                {
                    fieldData = [fieldData stringByAppendingString:[NSString stringWithFormat:@"\n%@", theOption]];
                }
            }
        }
        else if ([obj class] == [T4Plus class])
        {
            T4Plus *myObj = (T4Plus *)obj;
            if (myObj.product != nil)
            {
                NSString *theOption = [myObj.product description];
                if ([myObj.description isEqualToString:self.title.text])
                {
                    fieldData = [fieldData stringByAppendingString:[NSString stringWithFormat:@"\n%@", theOption]];
                }
            }
        }
        else if ([obj class] == [T1Carbon class])
        {
            T1Carbon *myObj = (T1Carbon *)obj;
            if (myObj.product != nil)
            {
                NSString *theOption = [myObj.product description];
                if ([myObj.description isEqualToString:self.title.text])
                {
                    fieldData = [fieldData stringByAppendingString:[NSString stringWithFormat:@"\n%@", theOption]];
                }
            }
        }
        else if ([obj class] == [T2Carbon class])
        {
            T2Carbon *myObj = (T2Carbon *)obj;
            if (myObj.product != nil)
            {
                NSString *theOption = [myObj.product description];
                if ([myObj.description isEqualToString:self.title.text])
                {
                    fieldData = [fieldData stringByAppendingString:[NSString stringWithFormat:@"\n%@", theOption]];
                }
            }
        }
        else if ([obj class] == [T3Carbon class])
        {
            T3Carbon *myObj = (T3Carbon *)obj;
            if (myObj.product != nil)
            {
                NSString *theOption = [myObj.product description];
                if ([myObj.description isEqualToString:self.title.text])
                {
                    fieldData = [fieldData stringByAppendingString:[NSString stringWithFormat:@"\n%@", theOption]];
                }
            }
        }
        else if ([obj class] == [T4Carbon class])
        {
            T4Carbon *myObj = (T4Carbon *)obj;
            if (myObj.product != nil)
            {
                NSString *theOption = [myObj.product description];
                if ([myObj.description isEqualToString:self.title.text])
                {
                    fieldData = [fieldData stringByAppendingString:[NSString stringWithFormat:@"\n%@", theOption]];
                }
            }
        }
        else if ([obj class] == [Aeria class])
        {
            Aeria *myObj = (Aeria *)obj;
            if (myObj.product != nil)
            {
                NSString *theOption = [myObj.product description];
                if ([myObj.description isEqualToString:self.title.text])
                {
                    fieldData = [fieldData stringByAppendingString:[NSString stringWithFormat:@"\n%@", theOption]];
                }
            }
        }
        else if ([obj class] == [ZBS class])
        {
            ZBS *myObj = (ZBS *)obj;
            if (myObj.product != nil)
            {
                NSString *theOption = [myObj.product description];
                if ([myObj.description isEqualToString:self.title.text])
                {
                    fieldData = [fieldData stringByAppendingString:[NSString stringWithFormat:@"\n%@", theOption]];
                }
            }
        }
    }];
    
    // SAVE THE DATA OUT TO THE DETAILS FIELD
    self.details.text = fieldData;
}

@end
