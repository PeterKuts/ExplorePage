//
//  PhotoCollectionViewController.m
//  ExplorePage
//
//  Created by user on 5/17/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "PhotoCollectionViewController.h"

@interface PhotoCollectionViewController()

@property (strong) PCServer *server;

@end

@implementation PhotoCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.title;
    self.navigationItem.hidesBackButton = YES;
}

- (void)setupServer:(PCServer*)server {
    if (self.server) {
        return;
    }
    self.server = server;
}

@end
