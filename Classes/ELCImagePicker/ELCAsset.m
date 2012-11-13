//
//  Asset.m
//
//  Created by Matt Tuzzolo on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "ELCAsset.h"
#import "ELCAssetTablePicker.h"

@implementation ELCAsset

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

-(id)initWithAsset:(ALAsset*)asset {
	
	if (self = [super initWithFrame:CGRectMake(0, 0, 0, 0)]) {
		
		self.asset = asset;
		
		CGRect viewFrames = CGRectMake(0, 0, 75, 75);
		
		UIImageView *assetImageView = [[UIImageView alloc] initWithFrame:viewFrames];
		[assetImageView setContentMode:UIViewContentModeScaleToFill];
		[assetImageView setImage:[UIImage imageWithCGImage:[self.asset thumbnail]]];
		[self addSubview:assetImageView];
		[assetImageView release];
        
        if (ALAssetTypeVideo == [self.asset valueForProperty:ALAssetPropertyType]) {
            
            NSNumber *duration = [self.asset valueForProperty:ALAssetPropertyDuration];
            int inputSeconds = [duration intValue];
            int hours =  inputSeconds / 3600;
            int minutes = ( inputSeconds - hours * 3600 ) / 60;
            int seconds = inputSeconds - hours * 3600 - minutes * 60;
            
            NSString *timeString;
            
            if (hours > 0) {
                timeString = [NSString stringWithFormat:@"%.2d:%.2d:%.2d ", hours, minutes, seconds];
            }
            else if (minutes > 0) {
                timeString = [NSString stringWithFormat:@"%.2d:%.2d ", minutes, seconds];
            }
            else {
                timeString = [NSString stringWithFormat:@"0:%.2d ", seconds];
            }
            
            UILabel *videoTime = [UILabel new];
            videoTime.frame = CGRectMake(0, 55, 75, 20);
            videoTime.textColor = [UIColor whiteColor];
            videoTime.font = [UIFont boldSystemFontOfSize:12];
            videoTime.textAlignment = NSTextAlignmentRight;
            videoTime.adjustsFontSizeToFitWidth = YES;
            videoTime.text = timeString;
            videoTime.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
            [self addSubview:videoTime];
            
            UIImageView *videoIcon = [UIImageView new];
            videoIcon.image = [UIImage imageNamed:@"iOS-Video-Icon"];
            videoIcon.frame = CGRectMake(4.0f, 61.0f, 14.0f, 8.0f);
            [self addSubview:videoIcon];
        }
    }
    
	return self;	
}

-(void)toggleSelection
{
    [(ELCAssetTablePicker*)self.parent doneAction:self.asset];
}

- (void)dealloc 
{    
    self.asset = nil;
    [super dealloc];
}

@end

