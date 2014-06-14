//
//  ItemView.m
//  blurTest
//
//  Created by dunkey on 2014. 6. 13..
//  Copyright (c) 2014년 dddd. All rights reserved.
//

#import "ItemView.h"

@implementation ItemView
@synthesize ivBG;

- (id) init {
	NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"ItemView" owner:self options:nil];
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


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//	ivBGImage.image = [UIImage imageNamed:@"pic"];
	
}


@end
