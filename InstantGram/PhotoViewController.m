//
//  DetailViewController.m
//  CameraTest
//
//  Created by cory Sturgis on 10/27/15.
//  Copyright © 2015 CorySturgis. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>
#import "PhotoViewController.h"
#import "Photo.h"


@interface PhotoViewController () <CLLocationManagerDelegate, MKMapViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property CLLocationManager *locationManager;
@property BOOL didFind;

@property PFFile *photoFile;
@property UIBackgroundTaskIdentifier fileUploadBackgroundTaskId;
@property UIBackgroundTaskIdentifier photoPostBackgroundTaskId;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.detailImageView.image = self.post.image;
    [self shouldUploadImage:self.post.image];

    self.descriptionTextView.delegate = self;
}

-(BOOL)shouldUploadImage:(UIImage *)image {

    NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);

    if (!imageData) {
        return NO;
    } else {
        self.photoFile = [PFFile fileWithData:imageData];
    }

    self.fileUploadBackgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:self.fileUploadBackgroundTaskId];
    }];

    [self.photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

        [[UIApplication sharedApplication] endBackgroundTask:self.fileUploadBackgroundTaskId];
    }];

    return YES;

}

- (void)cancelButtonAction:(id)sender {
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onShareButtonTapped:(id)sender {

    if (!self.photoFile) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Couldn't post your photo" message:nil preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:okay];
        [self presentViewController:alert animated:YES completion:nil];
    }

    PFObject *photo = [PFObject objectWithClassName:@"Photo"];

//    [photo setObject:[PFUser currentUser] forKey:@"user"];
    [photo setObject:self.photoFile forKey:@"image"];
    [photo setObject:self.descriptionTextView.text forKey:@"photoDescription"];

    if (self.post.userLocation != nil){
        [photo setObject:[PFGeoPoint geoPointWithLocation:self.post.userLocation] forKey:@"location"];
    }
//    PFACL *photoACL = [PFACL ACLWithUser:[PFUser currentUser]];
//    [photoACL setPublicReadAccess:YES];
//    photo.ACL = photoACL;

    self.photoPostBackgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:self.photoPostBackgroundTaskId];
    }];

    [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Photo Uploaded");
        }
    }];

    [self.delegate addPhotoToCollectionView:self.post];
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)onAddLocationButtonPressed:(UIButton *)sender {
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    [self.descriptionTextView resignFirstResponder];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = locations.firstObject;
    if (location.verticalAccuracy < 100 && location.horizontalAccuracy < 100 && self.didFind == !YES) {
        self.didFind = YES;
        self.post.userLocation = location;
        [self.locationManager stopUpdatingLocation];
    }
}


@end
