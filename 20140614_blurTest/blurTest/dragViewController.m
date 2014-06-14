//
//  dragViewController.m
//  blurTest
//
//  Created by dunkey on 2014. 6. 12..
//  Copyright (c) 2014년 dddd. All rights reserved.
//

#import "dragViewController.h"

@interface dragViewController ()

@end

@implementation dragViewController


- (void)viewDidLoad
{
	UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureCallback:)];
	[self.view addGestureRecognizer:gesture];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)gestureCallback:(UIPanGestureRecognizer *)recognizer {
	
	if (((recognizer.state == UIGestureRecognizerStateChanged) ||
		 (recognizer.state == UIGestureRecognizerStateEnded))) {
		
		CGPoint velocity = [recognizer velocityInView:self.view];
		
		if (velocity.x == 0 && velocity.y >0)   // panning down
		{
			NSLog(@"DOWN!!!");
//			self.brightness = self.brightness -.02;
			//     NSLog (@"Decreasing brigntness in pan");
		}
		else if(velocity.x == 0 && velocity.y < 0)
		{
			NSLog(@"UP!!!");
//			self.brightness = self.brightness +.02;
			//  NSLog (@"Increasing brigntness in pan");
		}
	}
}

@end
