//
//  PCObject.m
//  ExplorePage
//
//  Created by user on 5/17/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "PCObject.h"
#import "PCPhotoObject.h"

#import "NSDictionary+TypeCheck.h"

@interface PCObject ()

@property (nonatomic, copy, readwrite) NSNumber *modelId;
@property (nonatomic, assign, readwrite) PCObjectType objectType;

@end

@implementation PCObject

- (instancetype)init {
    if (self = [super init]) {
        self.objectType = PCObjectType_Unknown;
    }
    return self;
}

+ (__kindof PCObject*)instantiateObjectWithWithModelDictionary:(NSDictionary*)modelDictionary {
    PCObject *object = nil;
    if ([modelDictionary stringForKey:@"photo"]) {
        object = [[PCPhotoObject alloc] initWithModelDictionary:modelDictionary];
        object.objectType = PCObjectType_Photo;
    }
    object.modelId = [modelDictionary numberForKey:@"id"];
    return object;
}

@end
