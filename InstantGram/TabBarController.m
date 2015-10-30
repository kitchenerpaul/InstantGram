//
//  TabBarController.m
//  InstantGram
//
//  Created by Paul Kitchener on 10/30/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "TabBarController.h"
#import "PhotoViewController.h"

@interface TabBarController () <PhotoViewControllerDelegate, UITabBarControllerDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;
}

-(void)addPhotoToCollectionView:(Photo *)photo{
    NSLog(@"tab bar controller called");
    
}

@end
