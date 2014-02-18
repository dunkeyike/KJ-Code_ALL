//
//  UIColor+UserDefineColor.h
//  UIviewConCategory
//
//  Created by Dunkey on 2014. 2. 10..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UserDefineColor)
// make UIColor from 16bit string (00 - ff)
+ (UIColor *) colorFromHexCode:(NSString *)hexString;

// user define color
+ (UIColor *) user_waterColor;
+ (UIColor *) user_pinkColor;
+ (UIColor *) user_lightPinkColor;
+ (UIColor *) user_redColor;
+ (UIColor *) user_yellowColor;
+ (UIColor *) user_greenColor;

// make blend color with 2 colors
+ (UIColor *) blendedColorWithForegroundColor:(UIColor *)foregroundColor
                              backgroundColor:(UIColor *)backgroundColor
                                 percentBlend:(CGFloat) percentBlend;
@end
