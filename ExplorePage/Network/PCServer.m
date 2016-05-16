//
//  PCServer.m
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "PCServer.h"
#import "PCActivity.h"

NSString *const kPCServerErrorDomain = @"PCServerErrorDomain";


@interface PCServer()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, copy) NSURL *baseURL;

@end

@implementation PCServer

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


- (void)loadRootObjectCompletionHandler:(RootObjectCompletionHandler)completionHandler {
    [self loadRootObject:self.baseURL
       completionHandler:completionHandler];
}

- (void)loadRootObject:(NSURL*)url completionHandler:(RootObjectCompletionHandler)completionHandler {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request
                                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error) {
            completionHandler(nil, error);
            return;
        }
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            completionHandler(nil, error);
            return;
        }
        
        if (![jsonObject isKindOfClass:[NSDictionary class]]) {
            completionHandler(nil, [PCServer serverErrorWithCode:PCServerErrorCode_WrongRootObject]);
            return;
        }
        
        completionHandler(jsonObject, nil);
    }];
    [task resume];
}

#pragma mark - Errors 

+ (NSError*)serverErrorWithCode:(PCServerErrorCode)code {
    return [NSError errorWithDomain:kPCServerErrorDomain code:code userInfo:nil];
}

@end
