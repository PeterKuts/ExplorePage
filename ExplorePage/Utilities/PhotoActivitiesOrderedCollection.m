//
//  PhotoActivitiesOrderedCollection.m
//  ExplorePage
//
//  Created by user on 5/17/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "PhotoActivitiesOrderedCollection.h"

@interface PhotoActivitiesOrderedCollection()

@property (nonatomic, strong) NSMutableArray<PCActivity*> *activities;
@property (strong) NSNumber *minModelId;
@property (strong) NSNumber *maxModelId;

@end

@implementation PhotoActivitiesOrderedCollection

- (instancetype)init {
    if (self = [super init]) {
        self.activities = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray<PCActivity*>*)allActivities {
    return self.activities;
}

- (NSArray<NSIndexPath*>*)addActivities:(NSArray<PCActivity*> *)activities indexConstructor:(NSIndexPath*(^)(NSInteger index))indexConstructor {
    NSMutableArray<NSIndexPath*> *indexes = [NSMutableArray array];
    for (PCActivity *activity in activities) {
        if (!self.minModelId || [self.minModelId compare:activity.modelId] == NSOrderedDescending) {
            self.minModelId = activity.modelId;
        }
        if (!self.maxModelId || [self.maxModelId compare:activity.modelId] == NSOrderedAscending) {
            self.maxModelId = activity.modelId;
        }
        if (activity.object.objectType != PCObjectType_Photo) {
            continue;
        }
        NSInteger index = [self.activities indexOfObject:activity
                                           inSortedRange:NSMakeRange(0, self.activities.count)
                                                 options:NSBinarySearchingInsertionIndex
                                         usingComparator:^NSComparisonResult(PCActivity*  _Nonnull obj1, PCActivity*  _Nonnull obj2) {
                                             return [obj2.modelId compare:obj1.modelId];
                                         }];
        BOOL insert = index >= self.activities.count || ![[self.activities objectAtIndex:index] isEqual:activity];
        if (insert) {
            NSIndexPath *path = indexConstructor? indexConstructor(index): [NSIndexPath indexPathWithIndex:index];
            [indexes addObject:path];
            [self.activities insertObject:activity atIndex:index];
        }
    }
    return indexes;
}

@end
