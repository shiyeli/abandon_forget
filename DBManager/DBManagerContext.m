//
//  DBManagerContext.m
//  Forget_iOS
//
//  Created by 111 on 16/10/27.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "DBManagerContext.h"
#import <CoreData/CoreData.h>
@interface DBManagerContext()
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation DBManagerContext
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
- ( NSURL * _Nullable )applicationDocumentsDirectory {
    NSURL *fileUrl = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.predevsiri"];
    return fileUrl;
//    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return self.managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ForgetGroupDB" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ForgetGroupDB.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"the add persistentStore error:%@",error);
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSLog(@"the coordinator 为空...");
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support
- (void)saveContext {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
        if (managedObjectContext != nil) {
            NSError *error = nil;
            if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
                NSLog(@"the db save error:%@",error);
            }
        }
    });
   
}

+ (DBManagerContext *)shareInstance{
    static DBManagerContext *instance = nil;
    if (!instance) {
        instance = [[DBManagerContext alloc] init];
    }
    return instance;
}



#pragma mark ----DBManager Operation
+ (void)intentEvent_insertItem:(NSString *)title{
    IntentEvent *ie = [NSEntityDescription insertNewObjectForEntityForName:@"IntentEvent" inManagedObjectContext:[DBManagerContext shareInstance].managedObjectContext];
    [ie setEventTitle:title];
    [[DBManagerContext shareInstance] saveContext];
}

+ (NSArray <IntentEvent *> *)intentEvent_allIntentEvent{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"IntentEvent"];
    return [[DBManagerContext shareInstance].managedObjectContext executeFetchRequest:request error:nil];
}
@end
