//
//  UIColor+UserDefineColor.m
//  UIviewConCategory
//
//  Created by Dunkey on 2014. 2. 10..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "UIColor+UserDefineColor.h"

@implementation UIColor (UserDefineColor)
+ (UIColor *) colorFromHexCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark - User Custom Color
+ (UIColor *) user_waterColor {
	return [UIColor colorFromHexCode:@"21b8e5"];
}
+ (UIColor *) user_pinkColor {
	return [UIColor colorFromHexCode:@"f44981"];
}
+ (UIColor *) user_lightPinkColor {
	return [UIColor colorFromHexCode:@"f9a8c3"];
}

+ (UIColor *) user_redColor {
	return [UIColor colorFromHexCode:@"f24e46"];
}
+ (UIColor *) user_yellowColor {
	return [UIColor colorFromHexCode:@"ed9231"];
}
+ (UIColor *) user_greenColor {
	return [UIColor colorFromHexCode:@"53b765"];
}
#pragma mark - Blend Color
+ (UIColor *) blendedColorWithForegroundColor:(UIColor *)foregroundColor
                              backgroundColor:(UIColor *)backgroundColor
                                 percentBlend:(CGFloat) percentBlend {
    
    CGFloat onRed, offRed, newRed, onGreen, offGreen, newGreen, onBlue, offBlue, newBlue;
    [foregroundColor getRed:&onRed green:&onGreen blue:&onBlue alpha:nil];
    [backgroundColor getRed:&offRed green:&offGreen blue:&offBlue alpha:nil];
    newRed = onRed * percentBlend + offRed * (1-percentBlend);
    newGreen = onGreen * percentBlend + offGreen * (1-percentBlend);
    newBlue = onBlue * percentBlend + offBlue * (1-percentBlend);
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:1.0];
}

@end
