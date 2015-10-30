//
//  TabBarController.m
//  InstantGram
//
//  Created by Paul Kitchener on 10/30/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "TabBarController.h"
#import "PhotoViewController.h"
#import "ProfileViewController.h"

@interface TabBarController () <PhotoViewControllerDelegate, UITabBarControllerDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];


    for (int i = 0; i < self.viewControllers.count; i++) {
        NSLog(@"self.viewControllers[%i] == %@", i, (self.viewControllers[i]).class);
    }
}

-(void)addPhotoToCollectionView:(Photo *)photo{
    NSLog(@"tab bar controller called");
    ProfileViewController *pvc = self.viewControllers[3];
    [pvc updateCollectionViewWithPhoto:photo];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

@end
