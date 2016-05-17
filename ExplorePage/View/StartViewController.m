//
//  StartViewController.m
//  ExplorePage
//
//  Created by user on 5/17/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "StartViewController.h"
#import "PhotoCollectionViewController.h"
#import "PCServer.h"

static NSString *const ShowPhotoCollectionSegue = @"ShowPhotoCollectionSegue";

@interface StartViewController()

@property (strong) PCServer *server;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.title;
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                      diskCapacity:100 * 1024 * 1024
                                                          diskPath:@"PhotoCache"];
    self.server = [[PCServer alloc] initWithAuthorizationToken:@"Token CLLkHDPJEGwuqOuDf056Udh6pm6OK-zQkEMRk062Glk"
                                                      urlCache:cache];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:ShowPhotoCollectionSegue sender:nil];
    });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:ShowPhotoCollectionSegue]) {
        PhotoCollectionViewController *photoCollectionVC = segue.destinationViewController;
        [photoCollectionVC setupServer:self.server];
    }
}

@end
