//
//  MapViewController.m
//  InstantGram
//
//  Created by Paul Kitchener on 10/30/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MapViewController.h"


@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(41.87808499, -87.6329), 40000, 50000);
    [self dropPins];
}

-(void)dropPins{

    CLLocation *pinLocation = [[CLLocation alloc] initWithLatitude:[[self.pictureLocation valueForKey:@"latitude"] doubleValue] longitude:[[self.pictureLocation valueForKey:@"longitude"] doubleValue]];
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    annotation.coordinate = pinLocation.coordinate;

    [self.mapView addAnnotation:annotation];

}


//- (MKAnnotationView ​*)mapView:(MKMapView *​)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
//    customPinView.animatesDrop = YES;
//    return customPinView;
//}



@end