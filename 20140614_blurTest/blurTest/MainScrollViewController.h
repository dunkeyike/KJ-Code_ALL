//
//  MainScrollViewController.h
//  blurTest
//
//  Created by dunkey on 2014. 6. 12..
//  Copyright (c) 2014년 dddd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "ItemView.h"
#import "SubSettingView.h"
#import "UIImage+ImageEffects.h"

@interface MainScrollViewController : UIViewController <UIScrollViewDelegate, iCarouselDataSource, iCarouselDelegate, subSettingViewDelegate>{
	IBOutlet UIButton		*btnLeftTop;
	IBOutlet UIButton		*btnRightTop;
	IBOutlet UIScrollView	*scMainScrollView;
	IBOutlet iCarousel		*scPageScrollView;
	IBOutlet UIPageControl	*pcPageControl;
	BOOL					isShowingSubSettingView;
	NSInteger				indexCurrentPage;
	UIImage					*snapshot;
	SubSettingView			*subSettingView;
    UIImageView             *ivBlur;
}
@end
