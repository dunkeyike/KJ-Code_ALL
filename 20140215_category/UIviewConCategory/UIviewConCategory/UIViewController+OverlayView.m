//
//  UIViewController+OverlayView.m
//  UIviewConCategory
//
//  Created by Dunkey on 2014. 2. 6..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "UIViewController+OverlayView.h"
@implementation UIViewController (OverlayView)

- (void) showLayer:(NSString *)message {
	UIView *layer = [[UIView alloc] initWithFrame:self.view.bounds];

	
	UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
	label.textAlignment = NSTextAlignmentCenter;
	label.lineBreakMode = YES;
	label.numberOfLines = 0;
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.text = message;
	[layer addSubview:label];
	
	[self.view addSubview:layer];
	layer.backgroundColor = [[UIColor clearColor]colorWithAlphaComponent:0.0 ];
	
	[UIView animateWithDuration:0.5 animations:^{
		layer.backgroundColor = [[UIColor clearColor]colorWithAlphaComponent:0.5];
	}];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideLayer)];
	[self.view addGestureRecognizer:tap];
}
- (void) hideLayer {
	NSArray *subViews = [self.view subviews];
	UIView *layer = [subViews lastObject];
	
	[UIView animateWithDuration:0.25 animations:^{
		layer.alpha = 0.0;
	} completion:^(BOOL finished) {
		[layer removeFromSuperview];
	}];

}
@end
