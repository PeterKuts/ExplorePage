//
//  PCPhotoFetcher.h
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PhotoListCompletionHandler)(id _Nullable data, NSError * _Nullable error);

@interface PCPhotoFetcher : NSObject

- (instancetype)init;
- (instancetype)initWithAuthorizationToken:(NSString*)authorizationToken;
- (instancetype)initWithAuthorizationToken:(NSString*)authorizationToken urlCache:(NSURLCache* _Nullable)cache NS_DESIGNATED_INITIALIZER;

- (void)fetchPhotoListCompletionHandler:(PhotoListCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
