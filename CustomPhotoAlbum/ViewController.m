//
//  ViewController.m
//  CustomPhotoAlbum
//
//  Created by Balaji Malliswamy on 21/10/15.
//  Copyright © 2015 CodeSkip. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "CustomAlbum.h"

NSString * const CSAlbum = @"Code Skip";
NSString * const CSAssetIdentifier = @"assetIdentifier";
NSString * const CSAlbumIdentifier = @"albumIdentifier";

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSString *albumId;
    NSString *recentImg;
}

@property (nonatomic, strong) PHPhotoLibrary* library;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [CustomAlbum makeAlbumWithTitle:CSAlbum onSuccess:^(NSString *AlbumId)
     {
         albumId = AlbumId;
     }
                            onError:^(NSError *error) {
                                NSLog(@"probelm in creating album");
                            }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnOnClick:(id)sender
{
  
    [self Open_Library];
}
- (IBAction)getRecentImg:(id)sender
{
    [CustomAlbum getImageWithIdentifier:recentImg onSuccess:^(UIImage *image) {
        [self.imgView setImage:image];
    } onError:^(NSError *error) {
        NSLog(@"Not found!");
    }];
}


#pragma -
#pragma mark Image picker delegate methdos
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [CustomAlbum addNewAssetWithImage:image toAlbum:[CustomAlbum getMyAlbumWithName:CSAlbum] onSuccess:^(NSString *ImageId) {
        NSLog(@"%@",ImageId);
        recentImg = ImageId;
    } onError:^(NSError *error) {
        NSLog(@"probelm in saving image");
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


-(void)Open_Library
{
    // Create image picker controller
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // Set source to the camera
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    // Delegate is self
    
    // Allow editing of image ?
    imagePicker.allowsEditing = NO;
    // Show image picker
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}





@end
