//
//  ActivityCollectionViewCell.m
//  InstantGram
//
//  Created by Paul Kitchener on 10/30/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "ActivityCollectionViewCell.h"

@implementation ActivityCollectionViewCell

-(void)populateCollectionViewCell:(Photo *)photo {
    self.mainPhotoImageView.image = photo.image;
    self.profilePhotoImageView.image = nil;
    self.userNameLabel.text = nil;
    self.timeLabel.text = nil;
    self.numberOfLikesLabel.text = @"0";
}

@end
