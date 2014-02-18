//
//  UIViewController+OverlayView.m
//  UIviewConCategory
//
//  Created by Dunkey on 2014. 2. 6..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "UIViewController+OverlayView.h"
#import "UIImage+blur.h"
#import "UIView+ScreenShot.h"

@implementation UIViewController (OverlayView)
BOOL isShow = NO;

- (void) showBlurLayer:(NSString *)message {
	if (!isShow) {
		isShow = YES;
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
		
		UIImage *tempImg = [[UIImage alloc] init];
		tempImg = [self.view screenshot];
		
		UIImage *effectImage = nil;
//		UIImage *tempImg = [UIImage imageNamed:@"DisplayImage"];
		effectImage = [tempImg applyLightEffect];
		imageView.image = effectImage;
		imageView.alpha = 0.0f;
		imageView.tag = 100;

		[self.view addSubview:imageView];
		
		UILabel *lblClose = [[UILabel alloc] initWithFrame:self.view.bounds];
		lblClose.numberOfLines = 0;
		lblClose.textAlignment = NSTextAlignmentCenter;
		lblClose.textColor = [UIColor redColor];
		lblClose.font = [UIFont boldSystemFontOfSize:18];
		lblClose.text = @"Tap to Close";
		lblClose.tag = 101;
		lblClose.alpha = 0.0f;
		[self.view addSubview:lblClose];
		[UIView animateWithDuration:0.75f animations:^{
			imageView.alpha = 1.0f;
			lblClose.alpha = 1.0f;
		}];
		
//		imageView.frame = CGRectOffset(imageView.frame, 0, 600);
//		[UIView animateWithDuration:1.0f animations:^{
//			imageView.frame = CGRectOffset(imageView.frame, 0, -500);
//		}];
		
		
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideBlurLayer)];
		[self.view addGestureRecognizer:tap];

	}
}
- (void) hideBlurLayer {
	NSArray *subViews = [self.view subviews];
	UIImageView *imageView = nil;
	
	for (UIImageView *imgView in subViews) {
		if (imgView.tag == 100) {
			imageView = imgView;
		}
	}
	
	UILabel *lblClose = nil;
	for (UILabel *lbl in subViews) {
		if (lbl.tag == 101) {
			lblClose = lbl;
		}
	}
	if (imageView != nil) {
		[UIView animateWithDuration:0.75f animations:^{
			imageView.alpha = 0.0;
			lblClose.alpha = 0.0f;
		} completion:^(BOOL finished) {
			[imageView removeFromSuperview];
			[lblClose removeFromSuperview];
			
		}];
	}
	
	isShow = NO;
}
@end
