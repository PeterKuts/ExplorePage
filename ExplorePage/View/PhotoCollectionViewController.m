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
@property (assign) BOOL canLoadItems;
@property (assign) NSInteger batchSize;

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

    self.canLoadItems = YES;

    CGFloat precalcSide = self.view.frame.size.width/3.0;
    self.batchSize = (NSInteger)ceilf(self.view.frame.size.height / precalcSide) * 3;
    [self loadRootObjectWithLimit:self.batchSize loadNewest:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.photoCollection.collectionViewLayout;
    CGFloat side = (self.photoCollection.frame.size.width - layout.minimumInteritemSpacing*2.0)/3.0;
    layout.itemSize = CGSizeMake(side, side);
}

- (void)loadRootObjectWithLimit:(NSInteger)limit loadNewest:(BOOL)newest {
    if (!self.canLoadItems) {
        return;
    }
    self.canLoadItems = NO;
    __weak typeof(self) wSelf = self;
    [self.server loadRootObjectLimit:limit
                             afterId:newest? self.photoActivities.maxModelId: nil
                            beforeId:newest? nil: self.photoActivities.minModelId
                   completionHandler:^(PCRoot * _Nullable rootObject, NSError * _Nullable error)
     {
         if (error) {
             NSLog(@"%@", error);
             return;
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             __strong typeof(wSelf) sSelf = wSelf;
             [sSelf updatePhotoActivitiesWithRootObject:rootObject newest:newest];
         });
     }];
}

- (void)updatePhotoActivitiesWithRootObject:(PCRoot*)root newest:(BOOL)newest {
    [self.photoCollection performBatchUpdates:^{
        NSArray<NSIndexPath*>* indexPaths = [self.photoActivities addActivities:root.activities indexConstructor:^NSIndexPath *(NSInteger index) {
            return [NSIndexPath indexPathForItem:index inSection:0];
        }];
        [self.photoCollection insertItemsAtIndexPaths:indexPaths];
    } completion:^(BOOL finished) {
        self.canLoadItems = YES;
    }];
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
    BOOL bottomLoad = scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.size.height;
    if (bottomLoad && self.canLoadItems) {
        [self loadRootObjectWithLimit:self.batchSize loadNewest:NO];
    }
}

@end
