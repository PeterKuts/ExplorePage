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
@property (nonatomic, strong, readonly) NSArray<PCActivity*> *activities;

- (instancetype)initWithModelDictionary:(NSDictionary*)modelDictionary NS_DESIGNATED_INITIALIZER;

@end
