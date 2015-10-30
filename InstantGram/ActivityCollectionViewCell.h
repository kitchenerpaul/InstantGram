//
//  ActivityCollectionViewCell.h
//  InstantGram
//
//  Created by Paul Kitchener on 10/30/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface ActivityCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profilePhotoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mainPhotoImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfLikesLabel;

@property (weak, nonatomic) IBOutlet UIButton *likesButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;

@property Photo *photo;

-(void)populateCollectionViewCell:(Photo *)photo;

@end
