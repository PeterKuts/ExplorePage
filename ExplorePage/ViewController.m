//
//  ViewController.m
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "ViewController.h"
#import "PCServer.h"
#import "PCRoot.h"

@interface ViewController ()

@property (nonatomic, strong) PCServer *server;
@property (nonatomic, strong) PCRoot *root;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.root = [[PCRoot alloc] initWithTotalItems:0 activities:nil];
    self.server = [[PCServer alloc] initWithAuthorizationToken:@"Token CLLkHDPJEGwuqOuDf056Udh6pm6OK-zQkEMRk062Glk"
                                                             urlCache:nil];
    [self.server loadRootObjectLimit:10
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
