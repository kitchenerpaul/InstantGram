//
//  DetailViewController.m
//  CameraTest
//
//  Created by cory Sturgis on 10/27/15.
//  Copyright © 2015 CorySturgis. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PhotoViewController.h"
#import "Photo.h"


@interface PhotoViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property CLLocationManager *locationManager;
@property BOOL didFind;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.detailImageView.image = self.post.image;

}

- (IBAction)onShareButtonTapped:(id)sender {

    // save Photo object to parse

}

- (IBAction)onAddLocationButtonPressed:(UIButton *)sender {
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
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
