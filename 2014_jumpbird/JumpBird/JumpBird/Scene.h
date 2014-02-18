//
//  Scene.h
//  JumpBird
//
//  Created by Dunkey on 2014. 2. 18..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKScrollingNode.h"
#import "BirdNode.h"
#import "PipeNode.h"
#import "Score.h"

@protocol GameSceneDelegate <NSObject>
- (void) gameOver;
@end

@interface Scene : SKScene <SKPhysicsContactDelegate> {
	
    SKScrollingNode * floor;
    SKScrollingNode * city;
    SKScrollingNode * clouds;
    BirdNode * bird;
    
    int nbObstacles;
    NSMutableArray * topPipes;
    NSMutableArray * bottomPipes;
    
    int score;
    SKLabelNode * sklblScoreBG;
    
    bool isGameOver;
}
- (void) startGame;
@property (nonatomic, assign) id<GameSceneDelegate> delegate;
@end
