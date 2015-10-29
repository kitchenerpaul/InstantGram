//
//  PhotoCollectionViewCell.h
//  InstantGram
//
//  Created by Paul Kitchener on 10/29/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Photo.h"

@interface PhotoCollectionViewCell : UICollectionViewCell

@property Photo *photo;

@property (weak, nonatomic) IBOutlet UIImageView *profilePhotoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mainPhotoImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfLikesLabel;

@property (weak, nonatomic) IBOutlet UIButton *likesButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;


-(instancetype) initWithImage:(UIImage *)image andPhotoDescription:(NSString *)photoDescription andLocation:(CLLocation *)location andDate:(NSString *)date;

-(void)populateCollectionViewCell:(Photo *)photo;

@end