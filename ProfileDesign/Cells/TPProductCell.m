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
    if (self) {
        [self.title setTextColor:[UIColor purpleColor]];
    }
    return self;
}

-(void)setItem:(PDProducts*)newItem
{
    if (newItem != item)
    {
        item = nil;
        item = newItem;
        
        if (item != nil)
        {
            self.title.text = item.title;
            self.details.text = item.details;
            self.colors.text = item.color;
            self.material.text = item.material;
            self.armrest.text = item.armrest;
            self.armrestMaterial.text = item.armrestMaterial;
            self.weight.text = item.weight;
            
            NSString *imagePath = [NSString stringWithFormat:@"%@%@", IMAGES_PATH, item.imageFile];
            
            NSURL *imgUrl = [NSURL URLWithString:imagePath];
            NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
            UIImage *img = [UIImage imageWithData:imgData];
            [self.thumb setImage:img];
        }
    }
}


@end
