//
//  GenerateManager.m
//  ProfileDesign
//
//  Created by Matthew Rolufs on 10/10/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "GenerateManager.h"
#import "EvaluationManager.h"
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





@implementation GenerateManager





//- (void) generate{
//    
//    for(Product product : products){
//        
//        
//        
//        
//        recurseProduct(product);
//        
//    }
//    
//}

- (void) recurseProduct: (Product *) product{
	
    //Log.i("PRODUCTTYPE", product.getClass().getSimpleName());
    
    if([product class] == [T1Plus class] && !_isT1Plus){
        //addLine();
        _isT1Plus = true;
        t1Plus();
        [self optionalConfigurations];
    }
    else if([product class] == [T2Plus class] && !_isT2Plus){
        //addLine();
        _isT2Plus = true;
        t2Plus();
        [self optionalConfigurations];
    }
    else if([product class] == [T3Plus class] && !_isT3Plus){
        //addLine();
        _isT3Plus = true;
        t3Plus();
        [self optionalConfigurations];
    }
    else if([product class] == [T4Plus class] && !_isT4Plus){
        //addLine();
        _isT4Plus = true;
        t4Plus();
        [self optionalConfigurations];
    }
    else if([product class] == [T1Carbon class] && !_isT1Carbon){
        addLine();
        _isT1Carbon = true;
        t1Carbon();
        [self optionalConfigurations];
    }
    else if([product class] == [T2Carbon class] && !_isT2Carbon){
        //addLine();
        _isT2Carbon = true;
        t2Carbon();
        [self optionalConfigurations];
    }
    else if([product class] == [T3Carbon class] && !_isT3Carbon){
        //addLine();
        _isT3Carbon = true;
        t3Carbon();
        [self optionalConfigurations];
    }
    else if([product class] == [T4Carbon class] && !_isT4Carbon){
        //addLine();
        _isT4Carbon = true;
        t4Carbon();
        [self optionalConfigurations];
    }else if([product class] == [Aeria class] && !_isAeria){
        //addLine();
        _isAeria = true;
        //isT1Plus = true;
        _isT2Plus = true;
        //isT3Plus = true;
        _isT4Plus = true;
        _isT1Carbon = true;
        _isT2Carbon = true;
        _isT3Carbon = true;
        _isT4Carbon = true;
        
        aeria();
        
        if(!_isT1Plus && !_isT3Plus){
            [self optionalConfigurations];
        }
        
    }else if([product class] == [ZBS class] && !_isZBS){
        //addLine();
        _isZBS = true;
        zbsSBend();
        [self optionalConfigurations];
    }
    else{
        if([product class] != [Product class]){
            
            
            if(_isAeria){
                
                
                if(_isT1Plus && _isT3Plus){
                    
                    //don't generate
                    
                }else{
                    
                    if([product class] != [Aeria class]){
                        generateOptions(product);
                    }
                }
                
                
            }else{
				
                generateOptions(product);	
            }
        }
        else if([product class] == [Product class]){
            
            
            addLine();
            
        }
        
    }
    
    if(product.product != NULL){
        
        recurseProduct(product.product);
		
    }
    
}

- (void) optionalConfigurations{
    
//    TextView textView = new TextView(context);
//    textView.setText("Alternate Configurations:");
//    textView.setTextColor(Color.RED);
//    
//    productContainer.addView(textView);
    
}

@end
