//
//  CoreDataManager.h
//  Attendance
//
//  Created by Celestial on 07/11/24.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject

+ (instancetype)sharedManager;
- (NSManagedObjectContext *)managedObjectContext;
- (void)saveContext;

@end

NS_ASSUME_NONNULL_END
