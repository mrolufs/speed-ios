//
//  AppDelegate.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 6/5/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize hostStatus, internetStatus, wifiStatus;

+ (AppDelegate*) sharedAppDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveContext];
}



#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        
        [_managedObjectContext setMergePolicy:[[NSMergePolicy alloc] initWithMergeType:NSMergeByPropertyObjectTrumpMergePolicyType]];
    }
    return _managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ProfileDesign" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
    
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ProfileDesign.sqlite"];
    
    NSError *error = nil;
    NSDictionary *prag_options = @{@"journal_mode": @"DELETE"};
    NSDictionary *options = @{
                              NSMigratePersistentStoresAutomaticallyOption:[NSNumber numberWithBool:YES],
                              NSInferMappingModelAutomaticallyOption:[NSNumber numberWithBool:YES],
                              NSSQLitePragmasOption:prag_options};
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:options
                                                           error:&error])
    {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - Alert Message Method

- (void)alertWithMessage:(NSString *)msg withTitle:(NSString *)title
{
	
	if ([title length] == 0)
    title = @"Error";
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													message:msg
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles: nil];
	[alert show];
}


#pragma mark - Reachability Methods

-(BOOL)internetCheck {
	
	BOOL _isInternetConnectivity = YES;
	
	// check if there is internet connectivity
	[self performSelector:@selector(updateReachabilityStatus)];
	
	hostStatus = [hostReach currentReachabilityStatus];
	wifiStatus = [wifiReach currentReachabilityStatus];
	internetStatus = [internetReach currentReachabilityStatus];
	
	if (hostStatus == NotReachable && internetStatus == NotReachable && wifiStatus == NotReachable) {
		
		// alert the user that there is no internet connectivity
		NSString *errorString = @"There is Currently NO Internet Connectivity.\nYou will be unable to use Stylize effectively\nuntil connectivity has been restored.";
		[self alertWithMessage:errorString withTitle:@"ERROR"];
		
		_isInternetConnectivity = NO;
	}
	
	return _isInternetConnectivity;
}

- (void)updateReachabilityStatus
{
	hostStatus = [hostReach currentReachabilityStatus];
	wifiStatus = [wifiReach currentReachabilityStatus];
	internetStatus = [internetReach currentReachabilityStatus];
	
	if (hostStatus == NotReachable && internetStatus == NotReachable && wifiStatus == NotReachable) {
		
		// alert the user that there is no internet connectivity
		NSString *errorString = @"There is Currently NO Internet Connectivity.\nYou will be unable to use Stylize effectively\nuntil connectivity has been restored.";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
														message:errorString
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles: nil];
		[alert show];
	}
}

// Called by Reachability whenever status changes.
- (void)reachabilityChanged:(NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	
	if(curReach == hostReach)
    hostStatus = [curReach currentReachabilityStatus];
	else if (curReach == wifiReach)
    wifiStatus = [curReach currentReachabilityStatus];
	else if (curReach == internetReach)
    internetStatus = [curReach currentReachabilityStatus];
	
	[self updateReachabilityStatus];
}

@end
