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
	}
}
- (void) startPlay {
	// 충돌판정용 범위를 정하고
	[self setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, 5)]];
	// 충돌판정용 카테고리 설정
	self.physicsBody.categoryBitMask = birdBitMask;
	// 복원력 설정
	self.physicsBody.restitution = 1.8;
	// 무게설정
	self.physicsBody.mass = 0.1;

}
- (void) jumpBird {
	// 속도 조정
	[self.physicsBody setVelocity:CGVectorMake(0, 0)];
	// 점프량 설정 (자극력 설정)
	[self.physicsBody applyImpulse:CGVectorMake(0, 40)];
}
@end
