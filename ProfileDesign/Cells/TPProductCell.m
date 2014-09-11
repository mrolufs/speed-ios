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
@property (nonatomic, strong) IBOutlet UIImageView *thumb;
@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) IBOutlet UILabel *details;

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
            NSLog(@"\n\n----------\nProduct: %@\n----------\n\n",item.title);
            self.title.text = item.title;
            self.details.text = item.details;
            
            //NSString *productPath = [self cleanUpProductPath:[item productPath]];
            NSString *imagePath = [NSString stringWithFormat:@"%@%@", IMAGES_PATH, item.imageFile];
            
            NSURL *imgUrl = [NSURL URLWithString:imagePath];
            NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
            UIImage *img = [UIImage imageWithData:imgData];
            [self.thumb setImage:img];
        }
    }
}


@end
