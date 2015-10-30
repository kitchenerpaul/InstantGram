//
//  PhotoViewController.h
//  InstantGram
//
//  Created by cory Sturgis on 10/28/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;

@protocol PhotoViewControllerDelegate <NSObject>

-(void)addPhotoToCollectionView:(Photo *)photo;

@end

@interface PhotoViewController : UIViewController

@property Photo *post;
@property (nonatomic, assign) id<PhotoViewControllerDelegate> delegate;


@end
