//
//  ViewController.m
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "ViewController.h"
#import "PCServer.h"

@interface ViewController ()

@property (nonatomic, strong) PCServer *server;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.server = [[PCServer alloc] initWithAuthorizationToken:@"Token CLLkHDPJEGwuqOuDf056Udh6pm6OK-zQkEMRk062Glk"
                                                             urlCache:nil];
    [self.server loadRootObjectCompletionHandler:^(id  _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error:\n%@", error);
        } else {
            NSLog(@"Data:\n%@", data);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
