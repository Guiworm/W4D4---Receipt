//
//  DataManager.h
//  W4D4---Receipt++
//
//  Created by Dylan McCrindle on 2016-11-24.
//  Copyright © 2016 Dylan McCrindle. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface DataManager : NSObject

+ (DataManager*)sharedInstance;
- (NSArray *) fetchData:(NSString *)name;
- (NSArray *) fetchData:(NSString *)name withPredicate:(NSPredicate *)predicate;
- (void)saveContext;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@end
