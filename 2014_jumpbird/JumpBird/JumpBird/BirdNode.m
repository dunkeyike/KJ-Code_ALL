//
//  BirdNode.m
//  JumpBird
//
//  Created by Dunkey on 2014. 2. 18..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "BirdNode.h"

@implementation BirdNode

CGFloat lastVelocity = 0;

- (void) update:(NSTimeInterval) currentTime {
	shape.position = self.position;
	if (self.physicsBody.velocity.dy != lastVelocity) {
		self.zRotation = M_PI * self.physicsBody.velocity.dy * 0.0005;
		lastVelocity = self.physicsBody.velocity.dy;
		NSLog(@"lastVelocity : %f", lastVelocity);
	}
}
- (void) startPlay {
	// 충돌판정용 범위를 정하고
	[self setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(34, 20)]];
	// 충돌판정용 카테고리 설정
	self.physicsBody.categoryBitMask = birdBitMask;
	// 복원력 설정
	self.physicsBody.restitution = 0.01;
	// 무게설정
	self.physicsBody.mass = 0.1;
	
//	
//	SKSpriteNode *ship = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//	CGFloat offsetX = ship.frame.size.width * ship.anchorPoint.x;
//	CGFloat offsetY = ship.frame.size.height * ship.anchorPoint.y;
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, self.frame.origin.x, self.frame.origin.y);
	CGPathAddLineToPoint(path, NULL, self.frame.origin.x + self.frame.size.width, self.frame.origin.y);
	CGPathAddLineToPoint(path, NULL, self.frame.origin.x + self.frame.size.width, self.frame.origin.y + self.frame.size.height);
	CGPathAddLineToPoint(path, NULL, self.frame.origin.x, self.frame.origin.y + self.frame.size.height);
	CGPathAddLineToPoint(path, NULL, self.frame.origin.x, self.frame.origin.y);
	CGPathCloseSubpath(path);
	
//	ship.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
//	
//	[self addChild:ship];
//	
	shape = [SKShapeNode node];
	shape.path = path;
	shape.strokeColor = [SKColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
	shape.lineWidth = 1.0;
	[self addChild:shape];
	
}
- (void) jumpBird {
	// 속도 조정
	[self.physicsBody setVelocity:CGVectorMake(0, 0)];
	// 점프량 설정 (자극력 설정)
	[self.physicsBody applyImpulse:CGVectorMake(0, 40)];
}
@end
