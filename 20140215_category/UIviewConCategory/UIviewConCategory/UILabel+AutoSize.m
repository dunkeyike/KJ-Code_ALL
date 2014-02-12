//
//  UILabel+AutoSize.m
//  UIviewConCategory
//
//  Created by Dunkey on 2014. 2. 12..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "UILabel+AutoSize.h"

@implementation UILabel (AutoSize)
- (void) autosizeForWidth: (int) width {
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.numberOfLines = 0;

	CGSize maxSize = CGSizeMake(width, MAXFLOAT);
	
    CGRect labelRect = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];

    CGRect newFrame = self.frame;
    newFrame.size.height = labelRect.size.height;
    self.frame = newFrame;
}

@end
