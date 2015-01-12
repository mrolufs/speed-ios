//
//  PDDataManager.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 9/10/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "PDDataManager.h"
#import "AppDelegate.h"
#import "PDProducts.h"
#import "Constants.h"


@implementation PDDataManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static PDDataManager * sharedInstance;
    dispatch_once(&onceToken, ^(void)
                  {
                      sharedInstance = [[PDDataManager alloc] init];
                  });
    
    return sharedInstance;
}

- (NSArray *)fetchProductsUsingList:(NSArray *)productlist
{
    AppDelegate *ad = [AppDelegate sharedAppDelegate];
    NSManagedObjectContext *moc = [ad managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Products" inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    
    // SET SORT
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];

    // SET PREDICATE
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title IN $PRODUCTLIST"];
    fetchRequest.predicate = [predicate predicateWithSubstitutionVariables:
                                [NSDictionary dictionaryWithObject:productlist
                                                            forKey:@"PRODUCTLIST"]];
    
    // RETURN THE RESULTS
    NSError *error = nil;
    NSArray *resultObjects = [moc executeFetchRequest:fetchRequest error:&error];
    if (resultObjects == nil)
    {
        NSLog(@"Fetch error goes here");
    }
    
    return resultObjects;
}

- (NSArray *)fetchProduct:(NSString *)product
{
    AppDelegate *ad = [AppDelegate sharedAppDelegate];
    NSManagedObjectContext *moc = [ad managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Products" inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = %@", product];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *resultObjects = [moc executeFetchRequest:fetchRequest error:&error];
    if (resultObjects == nil)
    {
        NSLog(@"Fetch error goes here");
    }
    
    return [resultObjects firstObject];
}

- (NSArray *)fetchAllProducts
{
    AppDelegate *ad = [AppDelegate sharedAppDelegate];
    NSManagedObjectContext *moc = [ad managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Products" inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *resultObjects = [moc executeFetchRequest:fetchRequest error:&error];
    if (resultObjects == nil)
    {
        NSLog(@"Fetch error goes here");
    }
    
    return resultObjects;
}

#pragma mark - Load & Rest Product Data

- (void)loadDataAsInitial:(BOOL)initial withCompletion:(completionBlock)completion
{
    if (initial)
    {
        [self resetAllData];
    }
    
    AppDelegate *ad = [AppDelegate sharedAppDelegate];
    NSManagedObjectContext *moc = [ad managedObjectContext];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:TPLUS_PRODUCTS_JSON ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    for (id itm in json)
    {
        // STUFF JSON VALUES INTO VARIABLES
        NSString *title = [itm valueForKey:@"title"];
        NSString *details = [itm valueForKey:@"details"];
        NSString *color = [itm valueForKey:@"color"];
        NSString *productPath = [itm valueForKey:@"productPath"];
        NSString *productFile = [itm valueForKey:@"productFile"];
        NSString *material = [itm valueForKey:@"material"];
        NSString *armrestMaterial = [itm valueForKey:@"armrestMaterial"];
        NSString *armrest = [itm valueForKey:@"armrest"];
        NSString *imageFile = [itm valueForKey:@"imageFile"];
        NSString *weight = [itm valueForKey:@"weight"];
        
        // WRITE JSON VALUES TO THE DB
        PDProducts *product = [NSEntityDescription insertNewObjectForEntityForName:@"Products"
                                                             inManagedObjectContext:moc];
        [product setValue:title forKey:@"title"];
        [product setValue:details forKey:@"details"];
        [product setValue:color forKey:@"color"];
        [product setValue:productPath forKey:@"productPath"];
        [product setValue:productFile forKey:@"productFile"];
        [product setValue:material forKey:@"material"];
        [product setValue:armrestMaterial forKey:@"armrestMaterial"];
        [product setValue:armrest forKey:@"armrest"];
        [product setValue:imageFile forKey:@"imageFile"];
        [product setValue:weight forKey:@"weight"];
        [ad saveContext];
        
    }
    
    if (completion)
    {
        completion();
    }
}

- (void)resetAllData
{
    AppDelegate *ad = [AppDelegate sharedAppDelegate];
    NSManagedObjectContext *moc = [ad managedObjectContext];
    
    NSFetchRequest *allItems = [[NSFetchRequest alloc] init];
    [allItems setEntity:[NSEntityDescription entityForName:@"Products" inManagedObjectContext:moc]];
    [allItems setIncludesPropertyValues:NO];
    
    NSError *error = nil;
    NSArray *items = [moc executeFetchRequest:allItems error:&error];
    
    for (NSManagedObject *item in items)
    {
        [moc deleteObject:item];
    }
    
    NSError *saveError = nil;
    [moc save:&saveError];
}

@end
