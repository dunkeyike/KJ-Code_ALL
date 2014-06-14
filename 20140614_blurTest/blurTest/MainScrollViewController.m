//
//  MainScrollViewController.m
//  blurTest
//
//  Created by dunkey on 2014. 6. 12..
//  Copyright (c) 2014년 dddd. All rights reserved.
//

#import "MainScrollViewController.h"


@interface MainScrollViewController ()

@end

@implementation MainScrollViewController {
    NSArray *arrCoverTitle;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
	scMainScrollView.contentSize = CGSizeMake(320, 2893+200);
	scPageScrollView.type = iCarouselTypeTimeMachine;
	scPageScrollView.pagingEnabled = YES;
	isShowingSubSettingView = NO;
	pcPageControl.currentPage = 0;
	pcPageControl.numberOfPages = 5;
	indexCurrentPage = 0;
	[self.view bringSubviewToFront:scPageScrollView];
	[self.view bringSubviewToFront:pcPageControl];
	[self.view bringSubviewToFront:btnLeftTop];
	[self.view bringSubviewToFront:btnRightTop];
	
    ivBlur = [[UIImageView alloc] initWithFrame:self.view.frame];
    ivBlur.alpha = 0.0f;
    [self.view addSubview:ivBlur];
    [self.view bringSubviewToFront:ivBlur];
    
	subSettingView = [[SubSettingView alloc] init];
	subSettingView.delegate = self;
	subSettingView.frame = CGRectMake(0, self.view.frame.size.height, subSettingView.frame.size.width, subSettingView.frame.size.height);
	[self.view addSubview:subSettingView];
	[self.view bringSubviewToFront:subSettingView];
	
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panSubSettingView:)];
	[subSettingView addGestureRecognizer:pan];
    

    
    arrCoverTitle = [[NSArray alloc] initWithObjects:@"Eminem",@"Michael Jackson",@"Eminem2",@"Eminem Again",@"Modern", nil];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if ([scrollView isEqual:scMainScrollView]) {
		NSLog(@"scrollview content offset : %@",NSStringFromCGPoint(scrollView.contentOffset));
		
		if	(scrollView.contentOffset.y > 0 ) {
			scPageScrollView.frame = CGRectMake(0, -scrollView.contentOffset.y, 320, 200);
			pcPageControl.frame = CGRectMake(pcPageControl.frame.origin.x,
											 170 -scrollView.contentOffset.y,
											 pcPageControl.frame.size.width,
											 pcPageControl.frame.size.height);
			btnLeftTop.frame = CGRectMake(btnLeftTop.frame.origin.x,
										  20 -scrollView.contentOffset.y,
										  btnLeftTop.frame.size.width,
										  btnLeftTop.frame.size.height);
			
		} else {
			btnLeftTop.frame = CGRectMake(btnLeftTop.frame.origin.x,
										  scrollView.contentOffset.y + 20,
										  btnLeftTop.frame.size.width,
										  btnLeftTop.frame.size.height);
			
			btnRightTop.frame = CGRectMake(btnRightTop.frame.origin.x,
										  scrollView.contentOffset.y + 20,
										  btnRightTop.frame.size.width,
										  btnRightTop.frame.size.height);
			
			pcPageControl.frame = CGRectMake(pcPageControl.frame.origin.x,
											 170 -scrollView.contentOffset.y,
											 pcPageControl.frame.size.width,
											 pcPageControl.frame.size.height);
			
		}
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	[self.view bringSubviewToFront:scMainScrollView];
	[self.view bringSubviewToFront:pcPageControl];
	[self.view bringSubviewToFront:btnLeftTop];
	[self.view bringSubviewToFront:btnRightTop];
	[self.view bringSubviewToFront:subSettingView];
	
	
//	[[UIApplication sharedApplication] setStatusBarHidden:YES
//											withAnimation:UIStatusBarAnimationSlide];

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	NSLog(@"%s", __FUNCTION__);
	[self.view bringSubviewToFront:scPageScrollView];
	[self.view bringSubviewToFront:pcPageControl];
	[self.view bringSubviewToFront:btnLeftTop];
	[self.view bringSubviewToFront:btnRightTop];
	[self.view bringSubviewToFront:subSettingView];
	
//	[[UIApplication sharedApplication] setStatusBarHidden:NO
//											withAnimation:UIStatusBarAnimationSlide];
	
}

#pragma mark - UIKit Action Methods
- (IBAction)toggleBtn:(id)sender {
	NSLog(@"%s", __FUNCTION__);
}
- (IBAction)pageChanged:(id)sender {
	UIPageControl *pControl = (UIPageControl *) sender;
	scPageScrollView.autoscroll = pControl.currentPage;
}

- (IBAction) showSubSettingView:(id)sender {
    // Hide View
    if (isShowingSubSettingView) {
		isShowingSubSettingView = NO;
	
		[UIView animateWithDuration:0.3 animations:^{
			subSettingView.frame = CGRectMake(0, self.view.frame.size.height, subSettingView.frame.size.width, subSettingView.frame.size.height);
			ivBlur.alpha = 0.0f;
		} completion:^(BOOL finished) {
			snapshot = nil;
		}];
	}
    // Show View
    else {
		isShowingSubSettingView = YES;
		[self.view bringSubviewToFront:ivBlur];
        [self.view bringSubviewToFront:subSettingView];
		UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, 0.0);
		[self.view.window drawViewHierarchyInRect:self.view.window.bounds afterScreenUpdates:NO];
		snapshot = UIGraphicsGetImageFromCurrentImageContext();
		
		UIColor *tintColor = [UIColor colorWithWhite:0.7 alpha:0.5];
		UIImage *blurImg = [snapshot applyBlurWithRadius:5 tintColor:tintColor saturationDeltaFactor:0.8 maskImage:nil];
		ivBlur.image = blurImg;
		ivBlur.alpha = 0.0f;
		
		[UIView animateWithDuration:0.3 animations:^{
			subSettingView.frame = CGRectMake(0, self.view.frame.size.height / 2, subSettingView.frame.size.width, subSettingView.frame.size.height);
			ivBlur.alpha = 1.0f;

		} completion:^(BOOL finished) {
			
		}];
	}
	
}
#pragma mark - User Define Methods
- (void) returnFirstPage {
	scPageScrollView.autoscroll = 0;
}

- (void) panSubSettingView:(UIPanGestureRecognizer *)pan {
	
	
	CGPoint translation = [pan translationInView:self.view];
	pan.view.center = CGPointMake(pan.view.center.x,
										 pan.view.center.y + translation.y);
	[pan setTranslation:CGPointMake(0, 0) inView:self.view];
	

    NSLog(@"translation : %@",NSStringFromCGPoint(translation));
	NSLog(@"pan.view.center : %@",NSStringFromCGPoint(pan.view.center));

	
	float moveVal = pan.view.center.y - 568;
	NSLog(@"moveVal : %f",moveVal);

	UIColor *tintColor = [UIColor colorWithWhite:0.7 alpha:0.5];
	UIImage *blurImg = [snapshot applyBlurWithRadius:5 - (moveVal/30) tintColor:tintColor saturationDeltaFactor:0.4 maskImage:nil];
	ivBlur.image = blurImg;

	
	if (pan.state == UIGestureRecognizerStateEnded) {
		
		CGPoint velocity = [pan velocityInView:self.view];
		CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
		
        NSLog(@"velocity : %@",NSStringFromCGPoint(velocity));
        NSLog(@"magnitude : %f",magnitude);
        NSLog(@"slideMult : %f",slideMult);
        
        float slideFactor = 0.1 * slideMult;
        CGPoint finalPoint = CGPointMake(pan.view.center.x + (velocity.x * slideFactor),
										 pan.view.center.y + (velocity.y * slideFactor));
		
		NSLog(@"finalPoint : %@",NSStringFromCGPoint(finalPoint));
		
		
		
		if (finalPoint.y > 668) {
			NSLog(@"down!!!");
			[UIView animateWithDuration:0.2 animations:^{
				pan.view.frame = CGRectMake(pan.view.frame.origin.x,
											self.view.frame.size.height,
											pan.view.frame.size.width,
											pan.view.frame.size.height);
			} completion:^(BOOL finished) {
				[self showSubSettingView:nil];
			}];
			
		} else if(finalPoint.y < 468) {
			NSLog(@"up!!!");
			[UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
				pan.view.center = CGPointMake(pan.view.center.x, self.view.center.y);
			} completion:^(BOOL finished) {
				
			}];
		} else {
			NSLog(@"middle!!!");
			[UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
				pan.view.center = CGPointMake(pan.view.center.x, 568);
			} completion:^(BOOL finished) {
				
			}];
		}
	}
}

#pragma mark - iCarousel DataSource
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
	return 5;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
	ItemView *tempView = [[ItemView alloc]init];
    NSString *tep = [NSString stringWithFormat:@"cover_%02ld", index];
    UIImage *img = [UIImage imageNamed:tep];
    tempView.ivBG.image = img;
	return tempView;
}

#pragma mark - iCarousel Delegate
- (void)carouselWillBeginScrollingAnimation:(iCarousel *)carousel {
	NSLog(@"%s", __FUNCTION__);
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
	NSLog(@"%s", __FUNCTION__);
	pcPageControl.currentPage = carousel.currentItemIndex;
	if (carousel.currentItemIndex == 4) {
		[self performSelector:@selector(returnFirstPage) withObject:nil afterDelay:2.0];
	}
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
	NSLog(@"%s", __FUNCTION__);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Selected Item" message:[arrCoverTitle objectAtIndex:index] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
}


#pragma mark - SubSettingViewDelegate
- (void) toggleSubSettingViewClose {
	[self showSubSettingView:nil];
}

@end
