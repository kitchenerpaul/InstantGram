//
//  PhotoCollectionViewCell.m
//  InstantGram
//
//  Created by Paul Kitchener on 10/29/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

-(instancetype)initWithImage:(UIImage *)image andPhotoDescription:(NSString *)photoDescription andLocation:(CLLocation *)location andDate:(NSString *)date {

    self = [super init];

    if (self) {
        self.photo.image = image;
        self.photo.photoDescription = photoDescription;
        self.photo.userLocation = location;
        self.photo.timeStamp = date;
    }
    return self;
}

-(void)populateCollectionViewCell:(Photo *)photo {
    self.mainPhotoImageView.image = photo.image;
    self.profilePhotoImageView.image = nil;
    self.userNameLabel.text = nil;
    self.timeLabel.text = nil;
    self.numberOfLikesLabel.text = @"0";
}

@end
