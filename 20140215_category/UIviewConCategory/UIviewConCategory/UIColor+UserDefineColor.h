//
//  UIColor+UserDefineColor.h
//  UIviewConCategory
//
//  Created by Dunkey on 2014. 2. 10..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UserDefineColor)
// 16진수 칼라값으로부터 UIColor용(0-255) 숫자로 변경해서 칼라를 만듬
+ (UIColor *) colorFromHexCode:(NSString *)hexString;

// 사용자정의 칼라
+ (UIColor *) user_waterColor;
+ (UIColor *) user_pinkColor;
+ (UIColor *) user_lightPinkColor;
+ (UIColor *) user_redColor;
+ (UIColor *) user_yellowColor;
+ (UIColor *) user_greenColor;

// 두가지 칼라를 하나의 칼라로 만듬
+ (UIColor *) blendedColorWithForegroundColor:(UIColor *)foregroundColor
                              backgroundColor:(UIColor *)backgroundColor
                                 percentBlend:(CGFloat) percentBlend;
@end
