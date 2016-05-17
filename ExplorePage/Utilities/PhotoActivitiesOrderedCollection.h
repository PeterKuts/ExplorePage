//
//  PhotoActivitiesOrderedCollection.h
//  ExplorePage
//
//  Created by user on 5/17/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelClasses.h"

@interface PhotoActivitiesOrderedCollection : NSObject

@property (strong, readonly) NSArray<PCActivity*> *allActivities;
@property (strong, readonly) NSNumber *minModelId;
@property (strong, readonly) NSNumber *maxModelId;

- (NSArray<NSIndexPath*>*)addActivities:(NSArray<PCActivity*> *)activities indexConstructor:(NSIndexPath*(^)(NSInteger index))indexConstructor;

@end
