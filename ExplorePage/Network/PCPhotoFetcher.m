//
//  PCPhotoFetcher.m
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "PCPhotoFetcher.h"

@interface PCPhotoFetcher()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, copy) NSURL *baseURL;

@end

@implementation PCPhotoFetcher

- (instancetype)init {
    return [self initWithAuthorizationToken:@"" urlCache:nil];
}

- (instancetype)initWithAuthorizationToken:(NSString*)authorizationToken {
    return [self initWithAuthorizationToken:authorizationToken urlCache:nil];
}

- (instancetype)initWithAuthorizationToken:(NSString*)authorizationToken urlCache:(NSURLCache*)cache {
    if (self = [super init]) {
        //TODO: constructor parameter
        self.baseURL = [NSURL URLWithString:@"http://qa.api.petcube.com/api/v1/discover"];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.HTTPAdditionalHeaders = @{
                                                @"Content-Type": @"application/json",
                                                @"Authorization": authorizationToken
                                                };
        configuration.URLCache = cache;
        self.session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return self;
}


- (void)fetchPhotoListCompletionHandler:(PhotoListCompletionHandler)completionHandler {
    [self fetchPhotoList:self.baseURL
       completionHandler:completionHandler];
}

- (void)fetchPhotoList:(NSURL*)url completionHandler:(PhotoListCompletionHandler)completionHandler {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request
                                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error) {
            completionHandler(nil, error);
            return;
        }

        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if (error) {
            completionHandler(nil, error);
            return;
        }
        
        completionHandler(jsonObject, nil);
    }];
    [task resume];
}

@end
