//
//  GameHud.m
//  DragonFly
//
//  Created by Dunkey on 2013. 11. 11..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "GameHud.h"

@implementation GameHud
@synthesize lblScore;
- (void) setupNode {
    lblScore = [SKLabelNode labelNodeWithFontNamed:@"Copperplate"];
    lblScore.text = @"Score";
    lblScore.fontColor = [SKColor redColor];
    lblScore.fontSize = 16;
    lblScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    lblScore.position = CGPointMake(200, 550);
    [self addChild:lblScore];
}
@end
