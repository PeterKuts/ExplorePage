//
//  PhotoCollectionViewController.m
//  ExplorePage
//
//  Created by user on 5/17/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "PhotoCollectionViewController.h"

static NSString *const PhotoCollectionCellId = @"PhotoCollectionCellId";

@interface PhotoCollectionViewController() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong) PCServer *server;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollection;

@end

@implementation PhotoCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.title;
    self.navigationItem.hidesBackButton = YES;
    self.photoCollection.delegate = self;
    self.photoCollection.dataSource = self;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.photoCollection.collectionViewLayout;
    CGFloat side = (self.view.frame.size.width - layout.minimumInteritemSpacing*2.0)/3.0;
    layout.itemSize = CGSizeMake(side, side);
}

- (void)setupServer:(PCServer*)server {
    if (self.server) {
        return;
    }
    self.server = server;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCollectionCellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

@end
