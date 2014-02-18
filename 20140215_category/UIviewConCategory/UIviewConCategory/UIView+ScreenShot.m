//
//  UIView+ScreenShot.m
//  UIviewConCategory
//
//  Created by Dunkey on 2014. 2. 12..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "UIView+ScreenShot.h"

@implementation UIView (ScreenShot)

- (UIImage*)screenshot {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    image = [UIImage imageWithData:imageData];
    
    return image;
}

@end
