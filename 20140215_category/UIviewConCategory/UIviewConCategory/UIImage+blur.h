//
//  UIImage+blur.h
//  UIviewConCategory
//
//  Created by Dunkey on 2014. 2. 10..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (blur)
- (UIImage *)applyLightEffect;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
@end
