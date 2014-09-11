//
//  AppDelegate.h
//  ProfileDesign
//
//  Created by Lawrence Leach on 6/5/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    Reachability *hostReach;
    Reachability *internetReach;
    Reachability *wifiReach;
	
	NetworkStatus hostStatus;
	NetworkStatus internetStatus;
	NetworkStatus wifiStatus;
    
}

@property (strong, nonatomic) UIWindow *window;

@property NetworkStatus hostStatus;
@property NetworkStatus internetStatus;
@property NetworkStatus wifiStatus;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(AppDelegate*)sharedAppDelegate;

// REACHABILITY
- (BOOL)internetCheck;
- (void)updateReachabilityStatus;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
