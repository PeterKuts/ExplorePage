//
//  PCActivity.m
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "PCActivity.h"
#import "PCObject.h"

#import "NSDictionary+TypeCheck.h"

@interface PCActivity()

@property (nonatomic, copy, readwrite) NSNumber *modelId;
@property (nonatomic, strong, readwrite) PCObject *object;

@end

@implementation PCActivity

- (instancetype)init {
    return [self initWithModelDictionary:nil];
}

- (instancetype)initWithModelDictionary:(NSDictionary*)modelDictionary {
    if (self = [super init]) {
        self.modelId = [modelDictionary numberForKey:@"id"];
        NSDictionary *objectDict = [[modelDictionary dictionaryForKey:@"activity"] dictionaryForKey:@"object"];
        self.object = [[PCObject alloc] initWithModelDictionary:objectDict];
    }
    return self;
}

+ (NSArray<PCActivity*>*)activitiesWithModelArray:(NSArray<NSDictionary*>*)modelArray {
    NSMutableArray<PCActivity*> *activities = [NSMutableArray arrayWithCapacity:modelArray.count];
    for (NSDictionary *modelDict in modelArray) {
        [activities addObject:[[PCActivity alloc] initWithModelDictionary:modelDict]];
    }
    return activities;
}

@end
