//
//  PCObject.m
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "PCObject.h"
#import "PCPhoto.h"

#import "NSDictionary+TypeCheck.h"

@interface PCObject()

@property (nonatomic, copy, readwrite) NSNumber *modelId;
@property (nonatomic, strong, readwrite) PCPhoto *originalPhoto;
@property (nonatomic, strong, readwrite) NSArray<PCPhoto*> *photos;

@property (nonatomic, weak, readwrite) PCPhoto *smallestPhoto;

@end

@implementation PCObject

- (instancetype)init {
    return [self initWithModelDictionary:nil];
}

- (instancetype)initWithModelDictionary:(NSDictionary*)modelDictionary {
    if (self = [super init]) {
        self.modelId = [modelDictionary numberForKey:@"id"];
        self.originalPhoto = [[PCPhoto alloc] initWithUrlString:[modelDictionary stringForKey:@"photo"]
                                                 sizeDictionary:[modelDictionary dictionaryForKey:@"original_photo_resolution"]];
        self.photos = [PCPhoto photosWithModelArray:[modelDictionary arrayForKey:@"photos"]];
        self.smallestPhoto = [PCObject smallestPhoto:self.photos];
    }
    return self;
}

+ (PCPhoto*)smallestPhoto:(NSArray<PCPhoto*>*)photos {
    PCPhoto *smallestPhoto = nil;
    CGFloat minSquare = CGFLOAT_MAX;
    for (PCPhoto *photo in photos) {
        if (photo.size.width < FLT_EPSILON || photo.size.height < FLT_EPSILON) {
            continue;
        }
        CGFloat square = photo.size.width * photo.size.height;
        if (square < minSquare) {
            smallestPhoto = photo;
            minSquare = square;
        }
    }
    return smallestPhoto;
}

@end
