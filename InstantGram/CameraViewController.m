//
//  ViewController.m
//  CameraTest
//
//  Created by cory Sturgis on 10/27/15.
//  Copyright © 2015 CorySturgis. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "Photo.h"
#import "PhotoViewController.h"
#import "CameraViewController.h"


@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property BOOL newMedia;
@property Photo *post;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)onTakePhotoButtonPressed:(id)sender {

    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;

    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)onChooseExistingButtonPressed:(id)sender {

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:picker animated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    self.post = [[Photo alloc] initWithPhoto:image];


}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Picture Not Saved" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:errorAlert animated:YES completion:nil];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString: @"DetailPhotoViewer"]){
        PhotoViewController *dvc = segue.destinationViewController;
        dvc.post = self.post;
    }
}

@end
