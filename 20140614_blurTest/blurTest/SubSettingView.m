//
//  SubSettingView.m
//  blurTest
//
//  Created by dunkey on 2014. 6. 13..
//  Copyright (c) 2014년 dddd. All rights reserved.
//

#import "SubSettingView.h"

@implementation SubSettingView
@synthesize delegate;

- (id) init {
	NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"SubSettingView" owner:self options:nil];
	id mainView = [subviewArray objectAtIndex:0];
	return mainView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (IBAction)toggleClose:(id)sender {
	[delegate toggleSubSettingViewClose];
}

@end
