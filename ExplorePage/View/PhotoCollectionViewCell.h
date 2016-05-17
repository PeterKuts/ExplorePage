//
//  PhotoCollectionViewCell.h
//  ExplorePage
//
//  Created by user on 5/17/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelClasses.h"

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (weak) PCPhoto *photo;
- (void)setupImage:(UIImage*)image forPhoto:(PCPhoto*)photo;

@end
