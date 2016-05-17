//
//  PhotoCollectionViewController.m
//  ExplorePage
//
//  Created by user on 5/17/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "ModelClasses.h"
#import "PhotoActivitiesOrderedCollection.h"

static NSString *const PhotoCollectionCellId = @"PhotoCollectionCellId";

@interface PhotoCollectionViewController() <UICollectionViewDelegate, UICollectionViewDataSource>
@property (assign) BOOL canPreload;
@property (assign) BOOL canReload;


@property (strong) PCServer *server;
@property (strong) PhotoActivitiesOrderedCollection *photoActivities;

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollection;

@end

@implementation PhotoCollectionViewController

- (void)setupServer:(PCServer*)server {
    if (self.server) {
        return;
    }
    self.server = server;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoActivities = [[PhotoActivitiesOrderedCollection alloc] init];
    
    self.navigationItem.title = self.title;
    self.navigationItem.hidesBackButton = YES;
    self.photoCollection.delegate = self;
    self.photoCollection.dataSource = self;

    self.canReload = YES;
    self.canPreload = YES;

    CGFloat precalcSide = self.view.frame.size.width/3.0;
    NSInteger firstBatch = (NSInteger)ceilf(self.view.frame.size.height / precalcSide) * 3;
    [self loadRootObjectWithLimit:firstBatch after:NO];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.photoCollection.collectionViewLayout;
    CGFloat side = (self.photoCollection.frame.size.width - layout.minimumInteritemSpacing*2.0)/3.0;
    layout.itemSize = CGSizeMake(side, side);
}

- (void)loadRootObjectWithLimit:(NSInteger)limit after:(BOOL)after {
    __weak typeof(self) wSelf = self;
    [self.server loadRootObjectLimit:limit
                             afterId:after? self.photoActivities.maxModelId: nil
                            beforeId:after? nil: self.photoActivities.minModelId
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
    [self.photoCollection performBatchUpdates:^{
        NSArray<NSIndexPath*>* indexPaths = [self.photoActivities addActivities:root.activities indexConstructor:^NSIndexPath *(NSInteger index) {
            return [NSIndexPath indexPathForItem:index inSection:0];
        }];
        [self.photoCollection insertItemsAtIndexPaths:indexPaths];
    } completion:nil];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoActivities.allActivities.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCollectionCellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
}

@end
