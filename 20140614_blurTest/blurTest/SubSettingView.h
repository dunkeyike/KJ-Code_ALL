//
//  SubSettingView.h
//  blurTest
//
//  Created by dunkey on 2014. 6. 13..
//  Copyright (c) 2014년 dddd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol subSettingViewDelegate <NSObject>

- (void) toggleSubSettingViewClose;

@end
@interface SubSettingView : UIView

@property (nonatomic, assign) id <subSettingViewDelegate> delegate;

@end
