//
//  ProfileViewController.m
//  InstantGram
//
//  Created by Paul Kitchener on 10/27/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//
#import <Parse.h>
#import <FBSDKGraphRequest.h>
#import <ParseFacebookUtilsV4.h>
#import "ProfileViewController.h"
#import "Photo.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoViewController.h"
#import "MapViewController.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property NSMutableArray *cellPhotos;

@property NSString *usernameString;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _loadData];
    [self queryForTable];


}


- (IBAction)logoutButton:(id)sender {
    [PFUser logOut];
    [FBSDKAccessToken setCurrentAccessToken:nil];
    NSLog(@"User logged out Now");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateCollectionViewWithPhoto:(Photo *)photo{
        NSLog(@"cell photos array count -> %lu", self.cellPhotos.count);
    [self.cellPhotos insertObject:photo atIndex:0];

    [self.collectionView reloadData];
    NSLog(@"cell photos array count -> %lu", self.cellPhotos.count);
    NSLog(@"photo -> %@", photo);

}

- (void)_loadData {
    // ...
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name"}];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error) {

            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;

            NSString *facebookID = userData[@"id"];
            NSString *name = userData[
                                      @"name"];
            NSLog(@"%@", name);

            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];

            NSURLSession *session = [NSURLSession sharedSession];
            [[session dataTaskWithURL:pictureURL
                    completionHandler:^(NSData *data,
                                        NSURLResponse *response,
                                        NSError *error) {
                        self.imageView.image = [UIImage imageWithData:data];
                    }] resume];
            self.usernameLabel.text = name;
        }
    }];

    self.usernameLabel.text = [[PFUser currentUser] objectForKey:@"userName"];
    self.usernameString = [NSString new];
    self.usernameString = self.usernameLabel.text;

}

- (PFQuery *)queryForTable {

    self.cellPhotos = [NSMutableArray new];
    PFQuery *currentUserPhotosQuery = [PFQuery queryWithClassName:@"Photo"];
    NSString *userID = [PFUser currentUser].objectId;
    [currentUserPhotosQuery whereKey:@"userID" equalTo:userID];
//    [currentUserPhotosQuery whereKeyExists:@"image"];
    [currentUserPhotosQuery orderByDescending:@"createdAt"];

    [currentUserPhotosQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSLog(@"objects found --> %lu", objects.count);
//        [self.collectionView reloadData];

        for (PFObject *object in objects) {
            NSLog(@"%%%%%% ---> %@ // %@", object.objectId, object.createdAt);
            Photo *thisPhoto = [Photo new];
            PFFile *image = [object objectForKey:@"image"];
            [image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                if (!error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        thisPhoto.image = [UIImage imageWithData:data];

                        NSDate *date = object.createdAt;
                        NSLog(@"date -> %@", date);
                        if (date.timeIntervalSinceNow/-3600 < 1) {
                            thisPhoto.timeStamp = [NSString stringWithFormat:@"%.f minutes ago", date.timeIntervalSinceNow/-60];
                        } else {
                            thisPhoto.timeStamp = [NSString stringWithFormat:@"%.f hours ago", date.timeIntervalSinceNow/-3600];
                        }
                        NSLog(@"timeStamp --> %@", thisPhoto.timeStamp);
                        
                        CLLocation * loc = [object objectForKey:@"location"];
                        thisPhoto.userLocation = loc;

                    });

                    [self.cellPhotos addObject:thisPhoto];
                    [self.collectionView reloadData];

                } else {
                    NSLog(@"error: %@ %@", error, [error userInfo]);
                }
            }];
                    }
    }];

    NSLog(@"In photos array: %@", self.cellPhotos);
    return currentUserPhotosQuery;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cellPhotos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCellID" forIndexPath:indexPath];
    Photo *photo = [self.cellPhotos objectAtIndex:indexPath.row];
    
    cell.mainPhotoImageView.image = photo.image;
    cell.timeLabel.text = photo.timeStamp;
    cell.userNameLabel.text = @"Paul Kitchener";

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"MapViewSegue"]){
        MapViewController *dvc = segue.destinationViewController;
        NSArray *arrayOfIndexPaths = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *photoIndex = [arrayOfIndexPaths firstObject];
        Photo *photo = [self.cellPhotos objectAtIndex:photoIndex.row];
        NSLog(@"%@", photo);
        dvc.pictureLocation = photo.userLocation;
    }
}

-(IBAction)unwindToProfileVC:(UIStoryboardSegue *)segue {
    
}

@end
