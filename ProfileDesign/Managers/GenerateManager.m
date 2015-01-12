//
//  GenerateManager.m
//  ProfileDesign
//
//  Created by Matthew Rolufs on 10/10/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "GenerateManager.h"
#import "EvaluationManager.h"
#import "PDDataManager.h"
#import "PDProducts.h"
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

@interface GenerateManager ()

@property (nonatomic, strong) PDProducts *cdProduct;
@property (nonatomic, strong) NSMutableArray *productArray;
@property (nonatomic, strong) NSMutableDictionary *productOptions;

@end


@implementation GenerateManager

+ (instancetype)sharedGenerateManager
{
    static dispatch_once_t once_token;
    static GenerateManager * sharedInstance;
    
    dispatch_once(&once_token, ^(void)
    {
        sharedInstance = [[GenerateManager alloc] init];
    });
    
    return sharedInstance;
}

- (NSSet *)generateProducts:(NSArray *)productList
{
    self.productArray = [[NSMutableArray alloc] init];
    self.productOptions = [[NSMutableDictionary alloc] init];
    
    [productList enumerateObjectsUsingBlock:^(Product *product, NSUInteger idx, BOOL *stop)
    {
        [self.productArray addObject:[self newRecurseProduct:product]];
    }];
    
    return [NSSet setWithArray:self.productArray];
}

- (NSString *)newRecurseProduct:(Product *)product
{
    NSString *returnString = @"";
    
    if ([product class] == [T1Plus class] && !_isT1Plus)
    {
        _isT1Plus = YES;
    }
    else if ([product class] == [T2Plus class] && !_isT2Plus)
    {
        _isT2Plus = YES;
    }
    else if ([product class] == [T3Plus class] && !_isT3Plus)
    {
        _isT3Plus = YES;
    }
    else if ([product class] == [T4Plus class] && !_isT4Plus)
    {
        _isT4Plus = YES;
    }
    else if ([product class] == [T1Carbon class] && !_isT1Carbon)
    {
        _isT1Carbon = YES;
    }
    else if ([product class] == [T2Carbon class] && !_isT2Carbon)
    {
        _isT2Carbon = YES;
    }
    else if ([product class] == [T3Carbon class] && !_isT3Carbon)
    {
        _isT3Carbon = YES;
    }
    else if ([product class] == [T4Carbon class] && !_isT4Carbon)
    {
        _isT4Carbon = YES;
    }
    else if ([product class] == [Aeria class] && !_isAeria)
    {
        _isAeria = YES;
        //isT1Plus = YES;
        _isT2Plus = YES;
        //isT3Plus = YES;
        _isT4Plus = YES;
        _isT1Carbon = YES;
        _isT2Carbon = YES;
        _isT3Carbon = YES;
        _isT4Carbon = YES;
    }
    else if ([product class] == [ZBS class] && !_isZBS)
    {
        _isZBS = YES;
    }
    
    returnString = product.description;
    
    

    return returnString;

}

- (void) recurseProduct: (Product *) product
{
    if ([product class] == [T1Plus class] && !_isT1Plus)
    {
        _isT1Plus = YES;
        [self.productArray addObject:product.description];
    }
    else if ([product class] == [T2Plus class] && !_isT2Plus)
    {
        _isT2Plus = YES;
        [self.productArray addObject:[product class]];
    }
    else if ([product class] == [T3Plus class] && !_isT3Plus)
    {
        _isT3Plus = YES;
        [self.productArray addObject:[product class]];
    }
    else if ([product class] == [T4Plus class] && !_isT4Plus)
    {
        _isT4Plus = YES;
        [self.productArray addObject:[product class]];
    }
    else if ([product class] == [T1Carbon class] && !_isT1Carbon)
    {
        _isT1Carbon = YES;
        [self.productArray addObject:[product class]];
    }
    else if ([product class] == [T2Carbon class] && !_isT2Carbon)
    {
        _isT2Carbon = YES;
        [self.productArray addObject:[product class]];
    }
    else if ([product class] == [T3Carbon class] && !_isT3Carbon)
    {
        _isT3Carbon = YES;
        [self.productArray addObject:[product class]];
    }
    else if ([product class] == [T4Carbon class] && !_isT4Carbon)
    {
        _isT4Carbon = YES;
        [self.productArray addObject:[product class]];
    }
    else if ([product class] == [Aeria class] && !_isAeria)
    {
        _isAeria = YES;
        //isT1Plus = YES;
        _isT2Plus = YES;
        //isT3Plus = YES;
        _isT4Plus = YES;
        _isT1Carbon = YES;
        _isT2Carbon = YES;
        _isT3Carbon = YES;
        _isT4Carbon = YES;
        
        //aeria();
        
        [self.productArray addObject:[product class]];
    }
    else if ([product class] == [ZBS class] && !_isZBS)
    {
        _isZBS = YES;
        [self.productArray addObject:[product class]];
    }
    else
    {
        if ([product class] != [Product class])
        {
            
            
            if (_isAeria)  // GENERATE AERIA OPTIONS
            {
                if (_isT1Plus && _isT3Plus)
                {
                    //don't generate
                }
                else
                {
                    if ([product class] != [Aeria class])
                    {
                        //generateOptions(product);
                        [self generateOptions:product];
                        NSLog(@"Generating Aeria Options");
                    }
                }
            }
            else    // GENERATE OPTIONS FOR ALL OTHER PRODUCTS
            {
                //generateOptions(product);
                [self generateOptions:product];
                NSLog(@"Generating Non-Aeria Options");
            }
        }
        else if ([product class] == [Product class])
        {
            //addLine();
            NSLog(@"Add Line");
        }
    }
}

- (NSArray *) generateOptions:(Product *)product
{
    NSLog(@"%@", product);
    //NSArray *options;
    
    
    
//    TextView textView = new TextView(context);
//    textView.setText("Alternate Configurations:");
//    textView.setTextColor(Color.RED);
//    
//    productContainer.addView(textView);
    
    return @[];
}

@end
