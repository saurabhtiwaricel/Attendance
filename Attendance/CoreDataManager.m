//
//  CoreDataManager.m
//  Attendance
//
//  Created by Celestial on 07/11/24.
//

#import "CoreDataManager.h"
#import "AppDelegate.h"

@implementation CoreDataManager

+ (instancetype)sharedManager {
    static CoreDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSManagedObjectContext *)managedObjectContext {
    NSPersistentContainer *container = [(AppDelegate *)[[UIApplication sharedApplication] delegate] persistentContainer];
    return container.viewContext;
}

- (void)saveContext {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Failed to save context: %@, %@", error, [error userInfo]);
    }
}

@end
