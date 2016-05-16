//
//  PCRoot.m
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "PCRoot.h"
#import "PCActivity.h"

#import "NSDictionary+TypeCheck.h"

@interface PCRoot()

@property (nonatomic, assign, readwrite) NSInteger totalItems;
@property (nonatomic, strong, readwrite) NSOrderedSet<PCActivity*> *activities;

@end

@implementation PCRoot

- (instancetype)init {
    return [self initWithModelDictionary:nil];
}

- (instancetype)initWithModelDictionary:(NSDictionary*)modelDictionary {
    NSDictionary *data = [modelDictionary dictionaryForKey:@"data"];
    NSInteger totalItems = [[data numberForKey:@"totalItems"] integerValue];
    NSOrderedSet *activities = [NSOrderedSet orderedSetWithArray:[PCActivity activitiesWithModelArray:[data arrayForKey:@"items"]]];
    return [self initWithTotalItems:totalItems
                         activities:activities];
}

- (instancetype)initWithTotalItems:(NSInteger)totalItems activities:(NSOrderedSet<PCActivity*>*)activities {
    if (self = [super init]) {
        self.totalItems = totalItems;
        self.activities = activities;
    }
    return self;
}

- (PCRoot*)mergedWithRoot:(PCRoot*)another {
    NSInteger totalItems = MAX(self.totalItems, another.totalItems);
    NSMutableOrderedSet *activities = self.activities? [self.activities mutableCopy]: [[NSMutableOrderedSet alloc] init];
    [activities unionOrderedSet:another.activities];
    return [[PCRoot alloc] initWithTotalItems:totalItems activities:activities];
}

@end
