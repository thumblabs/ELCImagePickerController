//
//  ELCImagePickerController.m
//  ELCImagePickerDemo
//
//  Created by Collin Ruffenach on 9/9/10.
//  Copyright 2010 ELC Technologies. All rights reserved.
//

#import "ELCImagePickerController.h"
#import "ELCAsset.h"
#import "ELCAssetCell.h"
#import "ELCAssetTablePicker.h"
#import "ELCAlbumPickerController.h"

@implementation ELCImagePickerController

@synthesize delegate;

-(void)cancelImagePicker {
	if([delegate respondsToSelector:@selector(elcImagePickerControllerDidCancel:)]) {
		[delegate performSelector:@selector(elcImagePickerControllerDidCancel:) withObject:self];
	}
}

-(void)selectedAsset:(ALAsset*)asset elcAssets:(NSArray *)elcAssets {

    if (!asset) {
        [[self delegate] dismissModalViewControllerAnimated:YES];
        return;
    }
    
    NSMutableArray *assets = [[NSMutableArray alloc] initWithCapacity:[elcAssets count]];
    
    for (ELCAsset *elcAsset in elcAssets) {
        [assets addObject:elcAsset.asset];
    }
    
    NSMutableDictionary *workingDictionary = [[NSMutableDictionary alloc] init];
    [workingDictionary setObject:asset forKey:@"ELCImagePickerControllerAsset"];
    [workingDictionary setObject:assets forKey:@"ELCImagePickerControllerAssets"];
    
    
	if([delegate respondsToSelector:@selector(elcImagePickerController:didFinishPickingMediaWithInfo:)]) {
		[delegate performSelector:@selector(elcImagePickerController:didFinishPickingMediaWithInfo:)
                       withObject:self
                       withObject:workingDictionary];
	}
    
    [workingDictionary release];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {    
    NSLog(@"ELC Image Picker received memory warning.");
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    NSLog(@"deallocing ELCImagePickerController");
    [super dealloc];
}

@end
