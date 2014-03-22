//
//  KJParallaxAprite.h
//  shooting
//
//  Created by Dunkey on 2013. 11. 8..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface KJParallaxSprite : SKSpriteNode

@property (nonatomic) BOOL      usesParallaxEffect;
@property (nonatomic) CGFloat   virtualZRotation;

- (id)initWithSprites:(NSArray *)sprites usingOffset:(CGFloat)offset;
- (void) updateOffset;
@end
