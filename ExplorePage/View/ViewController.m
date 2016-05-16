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
@property (nonatomic, strong) NSMutableOrderedSet<PCActivity*> *photoActivities;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoActivities = [NSMutableOrderedSet orderedSet];
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                      diskCapacity:100 * 1024 * 1024
                                                          diskPath:@"PhotoCache"];
    self.server = [[PCServer alloc] initWithAuthorizationToken:@"Token CLLkHDPJEGwuqOuDf056Udh6pm6OK-zQkEMRk062Glk"
                                                      urlCache:cache];
}

- (void)loadRootObjectWithLimit:(NSInteger)limit {
    __weak typeof(self) wSelf = self;
    [self.server loadRootObjectLimit:limit
                             afterId:nil
                            beforeId:nil
                   completionHandler:^(PCRoot * _Nullable rootObject, NSError * _Nullable error)
     {
         if (error) {
             NSLog(@"%@", error);
             return;
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             __strong typeof(wSelf) sSelf = wSelf;
             [sSelf updatePhotoActivitiesWithRootObject:rootObject];
         });
     }];
}

- (void)updatePhotoActivitiesWithRootObject:(PCRoot*)root {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.object.objectType == %@ AND NOT self IN %@",
                              @(PCObjectType_Photo), self.photoActivities];
    NSArray<PCActivity*> *photoActivities = [root.activities filteredArrayUsingPredicate:predicate];
    [self.photoActivities addObjectsFromArray:photoActivities];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"======================DidReceiveMemoryWarning");
}

@end
