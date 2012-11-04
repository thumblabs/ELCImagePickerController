//
//  ELCImagePickerController.h
//  ELCImagePickerDemo
//
//  Created by Collin Ruffenach on 9/9/10.
//  Copyright 2010 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ELCImagePickerController : UINavigationController {

	id delegate;
}

@property (nonatomic, assign) id delegate;

-(void)selectedAsset:(ALAsset*)asset;
-(void)cancelImagePicker;

@end

@protocol ELCImagePickerControllerDelegate

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker;

@end

