//
//  KJParallaxAprite.m
//  shooting
//
//  Created by Dunkey on 2013. 11. 8..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "KJParallaxSprite.h"

@interface KJParallaxSprite ()
@property (nonatomic) CGFloat   parallaxOffset;
@end

@implementation KJParallaxSprite

#pragma mark - Initialization
- (id)initWithSprites:(NSArray *)sprites usingOffset:(CGFloat)offset {
    self = [super init];
    
    if (self) {
        _usesParallaxEffect = YES;
        
        // Make sure our z layering is correct for the stack.
        CGFloat zOffset = 1.0f / (CGFloat)[sprites count];
        
        // All nodes in the stack are direct children, with ordered zPosition.
        CGFloat ourZPosition = self.zPosition;
        NSUInteger childNumber = 0;
        for (SKNode *node in sprites) {
            node.zPosition = ourZPosition + (zOffset + (zOffset * childNumber));
            [self addChild:node];
            childNumber++;
        }
        
        _parallaxOffset = offset;
    }
    
    return self;
}

#pragma mark - Copying
- (id)copyWithZone:(NSZone *)zone {
    KJParallaxSprite *sprite = [super copyWithZone:zone];
    if (sprite) {
        sprite->_parallaxOffset = self.parallaxOffset;
        sprite->_usesParallaxEffect = self.usesParallaxEffect;
    }
    return sprite;
}

#pragma mark - Rotation and Offsets
- (void)setZRotation:(CGFloat)rotation {
    // Override to apply the zRotation just to the stack nodes, but only if the parallax effect is enabled.
    if (!self.usesParallaxEffect) {
        [super setZRotation:rotation];
        return;
    }
    
    if (rotation > 0.0f) {
        self.zRotation = 0.0f; // never rotate the group node
        
        // Instead, apply the desired rotation to each node in the stack.
        for (SKNode *child in self.children) {
            child.zRotation = rotation;
        }
        
        self.virtualZRotation = rotation;
    }
}

- (void)updateOffset {
    SKScene *scene = self.scene;
    SKNode *parent = self.parent;
    
    if (!self.usesParallaxEffect || parent == nil) {
        return;
    }
    
    CGPoint scenePos = [scene convertPoint:self.position fromNode:parent];
    
    // Calculate the offset directions relative to the center of the screen.
    // Bias to (-0.5, 0.5) range.
    CGFloat offsetX =  (-1.0f + (2.0 * (scenePos.x / scene.size.width)));
    CGFloat offsetY =  (-1.0f + (2.0 * (scenePos.y / scene.size.height)));
    
    CGFloat delta = self.parallaxOffset / (CGFloat)self.children.count;
    
    int childNumber = 0;
    for (SKNode *node in self.children) {
        node.position = CGPointMake(offsetX*delta*childNumber, offsetY*delta*childNumber);
        childNumber++;
    }
}


@end
