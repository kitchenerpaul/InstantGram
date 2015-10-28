//
//  Photo.h
//  InstantGram
//
//  Created by cory Sturgis on 10/28/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Photo : UIViewController

@property UIImage *image;
@property NSString *comment;
@property NSString *photoDescription;
@property CLLocation *userLocation;
@property NSNumber *likes;

-(instancetype)initWithPhoto:(UIImage *)photo;



@end
