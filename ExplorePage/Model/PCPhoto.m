//
//  PCPhoto.m
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "PCPhoto.h"
#import "NSDictionary+TypeCheck.h"

@interface PCPhoto()

@property (nonatomic, assign, readwrite) CGSize size;
@property (nonatomic, strong, readwrite) NSURL *url;

@end

@implementation PCPhoto

- (instancetype)init {
    return [self initWithModelDictionary:nil];
}

- (instancetype)initWithModelDictionary:(NSDictionary*)modelDictionary {
    return [self initWithUrlString:[modelDictionary stringForKey:@"url"] sizeDictionary:modelDictionary];
}

- (instancetype)initWithUrlString:(NSString*)urlString sizeDictionary:(NSDictionary*)sizeDictionary {
    if (self = [super init]) {
        self.url = [NSURL URLWithString:urlString];
        self.size = CGSizeMake([[sizeDictionary numberForKey:@"width"] floatValue],
                               [[sizeDictionary numberForKey:@"height"] floatValue]);
    }
    return self;
}

+ (NSArray<PCPhoto*>*)photosWithModelArray:(NSArray<NSDictionary*>*)modelArray {
    NSMutableArray<PCPhoto*> *photos = [NSMutableArray arrayWithCapacity:modelArray.count];
    for (NSDictionary *modelDict in modelArray) {
        [photos addObject:[[PCPhoto alloc] initWithModelDictionary:modelDict]];
    }
    return photos;
}


@end
