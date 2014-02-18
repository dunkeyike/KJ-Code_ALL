//
//  PipeNode.h
//  JumpBird
//
//  Created by Dunkey on 2014. 2. 18..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

typedef NS_ENUM(NSUInteger, PipeNodeType) {
	PipeNodeTypeTop,
	PipeNodeTypeBottom
};

@interface PipeNode : SKSpriteNode

@property (nonatomic) CGFloat		scrollingSpeed;
@property (nonatomic) PipeNodeType	type;

+ (PipeNode*) pipeOfType:(PipeNodeType)type;
@end
