//
//  SKScrollingNode.m
//  JumpBird
//
//  Created by Dunkey on 2014. 2. 18..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "SKScrollingNode.h"

@implementation SKScrollingNode
+ (id) spriteNodeWithImageNamed:(NSString *)name {
	UIImage *img = [UIImage imageNamed:name];
	SKScrollingNode *real = [SKScrollingNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(320, img.size.height)];
	real.scrollingSpeed = 1;
	
	float total = 0;
	while (total < (320 + img.size.height)) {
		SKSpriteNode *child = [SKSpriteNode spriteNodeWithImageNamed:name];
		[child setAnchorPoint:CGPointZero];
		[child setPosition:CGPointMake(total, 0)];
		[real addChild:child];
		total = total + child.size.width;
	}
	
	return real;
}

- (void) update:(NSTimeInterval)surrentTime {
	[self.children enumerateObjectsUsingBlock:^(SKSpriteNode *child, NSUInteger idx, BOOL *stop) {
		
		if (child.position.x <= -child.size.width) {
			float delta = child.position.x + child.size.width;
			child.position = CGPointMake(child.size.width * (self.children.count - 1) + delta, child.position.y);
		}
	}];
}
@end
