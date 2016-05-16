//
//  ViewController.m
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "ViewController.h"
#import "PCServer.h"
#import "ModelClasses.h"

@interface ViewController ()

@property (nonatomic, strong) PCServer *server;
@property (nonatomic, strong) PCRoot *root;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.root = [[PCRoot alloc] initWithTotalItems:0 activities:nil];
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                      diskCapacity:100 * 1024 * 1024
                                                          diskPath:@"PhotoCache"];
    self.server = [[PCServer alloc] initWithAuthorizationToken:@"Token CLLkHDPJEGwuqOuDf056Udh6pm6OK-zQkEMRk062Glk"
                                                      urlCache:cache];
    [self.server loadRootObjectLimit:3
                             afterId:nil
                            beforeId:nil
                   completionHandler:^(PCRoot * _Nullable rootObject, NSError * _Nullable error)
     {
         if (error) {
             NSLog(@"Error:\n%@", error);
             return;
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             self.root = [self.root mergedWithRoot:rootObject];
         });
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
