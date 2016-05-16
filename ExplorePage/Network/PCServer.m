//
//  PCServer.m
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "PCServer.h"
#import "PCRoot.h"
#import "PCPhoto.h"

NSString *const kPCServerErrorDomain = @"PCServerErrorDomain";


@interface PCServer()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, copy) NSURL *baseURL;
@property (nonatomic, copy) NSString *authorizationToken;

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
        self.authorizationToken = authorizationToken;
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.URLCache = cache;
        self.session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return self;
}

- (void)loadRootObjectLimit:(NSInteger)limit
                    afterId:(NSNumber*)afterId
                   beforeId:(NSNumber*)beforeId
          completionHandler:(RootObjectCompletionHandler)completionHandler
{
    NSURLComponents *components = [NSURLComponents componentsWithURL:self.baseURL resolvingAgainstBaseURL:NO];
    NSMutableArray<NSURLQueryItem *>* queryItems = [NSMutableArray arrayWithArray:components.queryItems];
    if (limit > 0) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"limit" value:[NSString stringWithFormat:@"%d", (int)limit]]];
    }
    if (afterId) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"afterId" value:[afterId stringValue]]];
    }
    if (beforeId) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:@"beforeId" value:[beforeId stringValue]]];
    }
    components.queryItems = queryItems.count? queryItems: nil;
    [self loadRootObject:[components URL] completionHandler:completionHandler];
}

- (void)loadRootObject:(NSURL*)url completionHandler:(RootObjectCompletionHandler)completionHandler {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.allHTTPHeaderFields = @{
                                    @"Content-Type": @"application/json",
                                    @"Authorization": self.authorizationToken
                                    };
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
        PCRoot *root = [[PCRoot alloc] initWithModelDictionary:jsonObject];
        completionHandler(root, nil);
    }];
    [task resume];
}

- (void)loadPhoto:(PCPhoto*)photo completionHandler:(PhotoCompletionHandler)completionHandler {
    NSURLRequest *request = [NSURLRequest requestWithURL:photo.url];

    __weak PCPhoto *weakPhoto = photo;
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        __strong PCPhoto *strongPhoto = weakPhoto;
        if (error) {
            completionHandler(strongPhoto, nil, error);
            return;
        }
        completionHandler(strongPhoto, [UIImage imageWithData:data], nil);
    }];
    [task resume];
}


#pragma mark - Errors 

+ (NSError*)serverErrorWithCode:(PCServerErrorCode)code {
    return [NSError errorWithDomain:kPCServerErrorDomain code:code userInfo:nil];
}

@end
