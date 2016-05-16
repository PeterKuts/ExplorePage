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
    NSLog(@"%@", [NSThread currentThread]);
    [self.server loadRootObjectCompletionHandler:^(PCRoot *_Nullable root, NSError * _Nullable error) {
        NSLog(@"%@", [NSThread currentThread]);
        if (error) {
            NSLog(@"Error:\n%@", error);
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", [NSThread currentThread]);
            self.root = [self.root mergedWithRoot:root];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
