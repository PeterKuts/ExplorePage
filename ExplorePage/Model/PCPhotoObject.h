//
//  PCPhotoObject.h
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCObject.h"

@class PCPhoto;

@interface PCPhotoObject : PCObject

@property (nonatomic, strong, readonly) PCPhoto *originalPhoto;
@property (nonatomic, strong, readonly) NSArray<PCPhoto*> *photos;

@property (nonatomic, weak, readonly) PCPhoto *smallestPhoto;

- (instancetype)initWithModelDictionary:(NSDictionary*)modelDictionary NS_DESIGNATED_INITIALIZER;

@end
