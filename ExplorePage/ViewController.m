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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                      diskCapacity:100 * 1024 * 1024
                                                          diskPath:@"PhotoCache"];
    self.server = [[PCServer alloc] initWithAuthorizationToken:@"Token CLLkHDPJEGwuqOuDf056Udh6pm6OK-zQkEMRk062Glk"
                                                      urlCache:cache];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
