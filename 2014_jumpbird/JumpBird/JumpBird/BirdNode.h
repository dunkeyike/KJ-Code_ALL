//
//  BirdNode.h
//  JumpBird
//
//  Created by Dunkey on 2014. 2. 18..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

@interface BirdNode : SKSpriteNode {
	SKShapeNode *shape;
}
- (void) update:(NSTimeInterval) currentTime;
- (void) startPlay;
- (void) jumpBird;
@end
