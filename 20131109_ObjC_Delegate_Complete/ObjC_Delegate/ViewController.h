//
//  ViewController.h
//  ObjC_Delegate
//
//  Created by Dunkey on 2013. 10. 30..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleView.h"

@interface ViewController : UIViewController <UIGestureRecognizerDelegate, SampleViewDelegate> {
    UIPanGestureRecognizer  *panGesture;
    IBOutlet SampleView     *sampleView;
    IBOutlet UILabel        *lblLikeCount;
    IBOutlet UILabel        *lblHateCount;
    NSInteger               likeCount;
    NSInteger               hateCount;
    BOOL                    isLike;
    BOOL                    isCancel;
    NSArray                 *arrImages;
    NSInteger               selectedImageIndex;
}

@end
