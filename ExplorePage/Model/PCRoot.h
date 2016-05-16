//
//  PCRoot.h
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PCActivity;

@interface PCRoot : NSObject

@property (nonatomic, assign, readonly) NSInteger totalItems;
@property (nonatomic, strong, readonly) NSOrderedSet<PCActivity*> *activities;

- (instancetype)initWithTotalItems:(NSInteger)totalItems activities:(NSOrderedSet<PCActivity*>*)activities NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithModelDictionary:(NSDictionary*)modelDictionary;

- (PCRoot*)mergedWithRoot:(PCRoot*)another;

@end
