//
//  SKScrollingNode.h
//  JumpBird
//
//  Created by Dunkey on 2014. 2. 18..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

@interface SKScrollingNode : SKSpriteNode

@property (nonatomic) CGFloat scrollingSpeed;

- (void) update:(NSTimeInterval)surrentTime;

@end
