//
//  GameHud.h
//  DragonFly
//
//  Created by Dunkey on 2013. 11. 11..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameHud : SKNode {
	
}
@property (nonatomic, strong) SKLabelNode	*lblScore;
- (void) setupNode;
@end
