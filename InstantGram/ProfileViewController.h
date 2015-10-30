//
//  ProfileViewController.h
//  InstantGram
//
//  Created by Paul Kitchener on 10/27/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface ProfileViewController : UIViewController

@property Photo *photo;

-(void)updateCollectionViewWithPhoto:(Photo *)photo;

@end
