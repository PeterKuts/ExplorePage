//
//  PCPhoto.h
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface PCPhoto : NSObject

@property (nonatomic, assign, readonly) CGSize size;
@property (nonatomic, strong, readonly) NSURL *url;

- (instancetype)initWithModelDictionary:(NSDictionary*)modelDictionary;
- (instancetype)initWithUrlString:(NSString*)urlString sizeDictionary:(NSDictionary*)sizeDictionary NS_DESIGNATED_INITIALIZER;

+ (NSArray<PCPhoto*>*)photosWithModelArray:(NSArray<NSDictionary*>*)modelArray;

@end
