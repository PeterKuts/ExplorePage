//
//  PCActivity.h
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PCObject;

@interface PCActivity : NSObject

@property (nonatomic, copy, readonly) NSNumber *modelId;
@property (nonatomic, strong, readonly) PCObject *object;

- (instancetype)initWithModelDictionary:(NSDictionary*)modelDictionary NS_DESIGNATED_INITIALIZER;

+ (NSArray<PCActivity*>*)activitiesWithModelArray:(NSArray<NSDictionary*>*)modelArray;

@end
