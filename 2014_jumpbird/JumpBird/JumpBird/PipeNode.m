//
//  PipeNode.m
//  JumpBird
//
//  Created by Dunkey on 2014. 2. 18..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "PipeNode.h"

@interface PipeNode ()
@property (strong,nonatomic) SKSpriteNode * cap;
@property (strong,nonatomic) SKSpriteNode * tube;
@end


@implementation PipeNode
+ (PipeNode*) pipeOfType:(PipeNodeType)type {
	PipeNode *node = [PipeNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(55, 1)];
	node.name = @"Pipe";
	node.anchorPoint = CGPointZero;
	node.type = type;
	
	node.tube = [SKSpriteNode spriteNodeWithImageNamed:@"pipeTube"];
	node.tube.name = @"Tube";
	node.tube.anchorPoint = CGPointZero;
	[node addChild:node.tube];
	
	if (type == PipeNodeTypeTop) {
		node.cap = [SKSpriteNode spriteNodeWithImageNamed:@"pipeTubeCapTop"];
	} else {
		node.cap = [SKSpriteNode spriteNodeWithImageNamed:@"pipeTubeCapBottom"];
	}
	
	node.cap.name = @"Cap";
	node.cap.anchorPoint = CGPointZero;
	
	[node addChild:node.cap];
	
	return node;
}

- (void) setSize:(CGSize)size {
	[super setSize:size];
	self.cap.size = CGSizeMake(55, 30);
	self.tube.size = size;
	
	switch (self.type) {
		case PipeNodeTypeTop:
			self.cap.position = CGPointZero;
			break;
		case PipeNodeTypeBottom:
			self.cap.position = CGPointMake(0, self.size.height - self.cap.size.height);
			break;
	}

}
@end
