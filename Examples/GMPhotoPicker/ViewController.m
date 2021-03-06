//
//  ViewController.m
//  GMPhotoPicker
//
//  Created by Guillermo Muntaner Perelló on 17/09/14.
//  Copyright (c) 2014 Guillermo Muntaner Perelló. All rights reserved.
//

#import "ViewController.h"
#import "GMImagePickerController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@import UIKit;
@import Photos;


@interface ViewController () <GMImagePickerControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)launchGMImagePicker:(id)sender
{
    GMImagePickerController *picker = [[GMImagePickerController alloc] init];
    picker.delegate = self;
    picker.title = @"Custom title";
    picker.customNavigationBarPrompt = @"Custom helper message!";
    picker.colsInPortrait = 3;
    picker.colsInLandscape = 5;
    picker.minimumInteritemSpacing = 2.0;
    picker.modalPresentationStyle = UIModalPresentationPopover;

    picker.showsDoneButtonItem = NO;
    picker.allowsMultipleSelection = NO;
    picker.allowsVideoEditing = YES;
    picker.maxVideoDuration = 2.;
    
    UIPopoverPresentationController *popPC = picker.popoverPresentationController;
    popPC.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popPC.sourceView = _gmImagePickerButton;
    popPC.sourceRect = _gmImagePickerButton.bounds;
    
    [self showViewController:picker sender:nil];
}

- (IBAction)launchUIImagePicker:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.modalPresentationStyle = UIModalPresentationPopover;

    picker.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeVideo, (NSString *)kUTTypeImage];
    picker.allowsEditing = YES;
    picker.videoMaximumDuration = 2.;
    
    UIPopoverPresentationController *popPC = picker.popoverPresentationController;
    popPC.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popPC.sourceView = _uiImagePickerButton;
    popPC.sourceRect = _uiImagePickerButton.bounds;
    
    [self showViewController:picker sender:sender];
}


#pragma mark - UIImagePickerControllerDelegate


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"UIImagePickerController: User ended picking assets");
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"UIImagePickerController: User pressed cancel button");
}

#pragma mark - GMImagePickerControllerDelegate

- (void)assetsPickerController:(GMImagePickerController *)picker didFinishPickingAssets:(NSArray *)assetArray
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"GMImagePicker: User ended picking assets. Number of selected items is: %lu", (unsigned long)assetArray.count);
}

//Optional implementation:
-(void)assetsPickerControllerDidCancel:(GMImagePickerController *)picker
{
    NSLog(@"GMImagePicker: User pressed cancel button");
}

#pragma mark UIVideoEditorControllerDelegate cover methods

- (void)assetsPickerController:(GMImagePickerController *)picker videoEditorController:(UIVideoEditorController *)editor didSaveEditedVideoToPath:(NSString *)editedVideoPath; // edited video is saved to a path in app's temporary directory
{
    [editor dismissViewControllerAnimated:YES completion:^{
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)assetsPickerController:(GMImagePickerController *)picker videoEditorController:(UIVideoEditorController *)editor didFailWithError:(NSError *)error;
{
    [editor dismissViewControllerAnimated:YES completion:^{
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)assetsPickerController:(GMImagePickerController *)picker videoEditorController:(UIVideoEditorController *)editor;
{
    [editor dismissViewControllerAnimated:YES completion:nil];
}

@end
