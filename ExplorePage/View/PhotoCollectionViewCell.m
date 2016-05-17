//
//  PhotoCollectionViewCell.m
//  ExplorePage
//
//  Created by user on 5/17/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@interface PhotoCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PhotoCollectionViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.photo = nil;
    self.imageView.image = nil;
    [self.imageView setHidden:YES];
    [self.activityIndicator startAnimating];
}

- (void)setupImage:(UIImage *)image forPhoto:(PCPhoto *)photo {
    if (!image || !photo || ![self.photo.url isEqual:photo.url]) {
        return;
    }
    self.imageView.image = image;
    [self.imageView setHidden:NO];
    [self.activityIndicator stopAnimating];
}

@end
