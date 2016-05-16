//
//  PCServer.h
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PCRoot;

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kPCServerErrorDomain;

typedef enum : NSUInteger {
    PCServerErrorCode_WrongRootObject,
} PCServerErrorCode;



typedef void(^RootObjectCompletionHandler)(PCRoot * _Nullable rootObject, NSError * _Nullable error);

@interface PCServer : NSObject

- (instancetype)init;
- (instancetype)initWithAuthorizationToken:(NSString*)authorizationToken;
- (instancetype)initWithAuthorizationToken:(NSString*)authorizationToken urlCache:(NSURLCache* _Nullable)cache NS_DESIGNATED_INITIALIZER;

- (void)loadRootObjectCompletionHandler:(RootObjectCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
