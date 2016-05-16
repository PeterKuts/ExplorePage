//
//  PCObject.h
//  ExplorePage
//
//  Created by user on 5/17/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PCObjectType_Unknown,
    PCObjectType_Photo,
} PCObjectType;

@interface PCObject : NSObject

@property (nonatomic, copy, readonly) NSNumber *modelId;
@property (nonatomic, assign, readonly) PCObjectType objectType;

+ (__kindof PCObject*)instantiateObjectWithWithModelDictionary:(NSDictionary*)modelDictionary;

@end
