//
//  Scene.m
//  JumpBird
//
//  Created by Dunkey on 2014. 2. 18..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "Scene.h"

#define FIRST_BLOCK_PADDING 100

#define FLOOR_SCROLLING_SPEED 5

#define VERTICAL_GAP_SIZE 200
#define BLOCK_WIDTH 55
#define BLOCK_MIN_HEIGHT 40
#define BLOCK_INTERVAL_SPACE 40

@implementation Scene

- (id) initWithSize:(CGSize)size {
	if (self = [super initWithSize:size]) {
		self.physicsWorld.contactDelegate = self;
		[self startGame];
	}
	return self;
}
- (void) startGame {
	isGameOver = NO;
	
	[self removeAllChildren];
	
	[self createBackground];
	[self createScore];
	[self createFloor];
	[self createLandscape];
	[self createBird];
	[self createBlocks];
}

- (void) createBackground {
	SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"back"];
	background.anchorPoint = CGPointZero;
	[self addChild:background];
}
- (void) createScore {
	score = 0;
	sklblScoreBG = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Bold"];
	sklblScoreBG.text = @"0";
	sklblScoreBG.fontSize = 500;
	sklblScoreBG.position = CGPointMake(CGRectGetMidX(self.frame), 100);
	sklblScoreBG.alpha = 0.2f;
	[self addChild:sklblScoreBG];
}

- (void) createFloor {
	floor = [SKScrollingNode spriteNodeWithImageNamed:@"floor"];
	[floor setScrollingSpeed:FLOOR_SCROLLING_SPEED];
	[floor setAnchorPoint:CGPointZero];
	[floor setName:@"floor"];
	[floor setPhysicsBody:[SKPhysicsBody bodyWithEdgeLoopFromRect:floor.frame]];
	floor.physicsBody.dynamic = NO;
	floor.physicsBody.categoryBitMask = floorBitMask;
	floor.physicsBody.contactTestBitMask = birdBitMask;
	[self addChild:floor];
	
}
- (void) createLandscape {
	clouds = [SKScrollingNode spriteNodeWithImageNamed:@"clouds"];
    clouds.anchorPoint = CGPointZero;
    clouds.position = CGPointMake(0, floor.size.height + 30);
    clouds.scrollingSpeed = 1;
    clouds.alpha = .5;
    [self addChild:clouds];
    
    city = [SKScrollingNode spriteNodeWithImageNamed:@"city"];
    city.anchorPoint = CGPointZero;
    city.position = CGPointMake(0, floor.size.height);
    city.scrollingSpeed = 1.5;
    [self addChild:city];

}
- (void) createBird {
    bird = [BirdNode spriteNodeWithImageNamed:@"bird"];
    [bird setPosition:CGPointMake(120, CGRectGetMidY(self.frame))];
    [bird setName:@"bird"];
    [self addChild:bird];
}
- (void) createBlocks {
	nbObstacles = 5;
	
	CGFloat lastBlockPos = 0;
//	bottomPipes = [NSMutableArray new];
//	topPipes = [NSMutableArray new];
	bottomPipes = @[].mutableCopy;
	topPipes = @[].mutableCopy;
	
	for (int i = 0; i < nbObstacles; i++) {
		PipeNode *topPipe = [PipeNode pipeOfType:PipeNodeTypeTop];
		[topPipe setAnchorPoint:CGPointZero];
		PipeNode *bottomPipe = [PipeNode pipeOfType:PipeNodeTypeBottom];
		
		[self addChild:topPipe];
		[bottomPipes addObject:topPipe];
		
		[self addChild:bottomPipe];
		[topPipes addObject:bottomPipe];
		
		if (i == 0) {
			[self place:bottomPipe and:topPipe atX:self.frame.size.width + FIRST_BLOCK_PADDING];
		} else {
			[self place:bottomPipe and:topPipe atX:lastBlockPos + BLOCK_WIDTH + BLOCK_INTERVAL_SPACE];
		}
		lastBlockPos = topPipe.position.x;
	}
}

- (void) place:(SKSpriteNode *) bottomBlock and:(SKSpriteNode *) topBlock atX:(float) xPos {
	float space = self.frame.size.height - floor.frame.size.height;
	
	float bottomBlockHeight = [self randomFloatBetween:BLOCK_MIN_HEIGHT and:(BLOCK_MIN_HEIGHT, space - VERTICAL_GAP_SIZE - BLOCK_MIN_HEIGHT)];
	bottomBlock.size = CGSizeMake(BLOCK_WIDTH, bottomBlockHeight);
	bottomBlock.position = CGPointMake(xPos, floor.frame.size.height);
	bottomBlock.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, BLOCK_WIDTH, bottomBlockHeight)];
	bottomBlock.physicsBody.categoryBitMask = blockBitMask;
	bottomBlock.physicsBody.contactTestBitMask = birdBitMask;
	
	float topBlockHeight = space - bottomBlockHeight - VERTICAL_GAP_SIZE;
	float topBlockYPos = floor.frame.size.height + bottomBlockHeight + VERTICAL_GAP_SIZE;
	topBlock.size = CGSizeMake(BLOCK_WIDTH, topBlockHeight);
	topBlock.position = CGPointMake(xPos, topBlockYPos);
	topBlock.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, BLOCK_WIDTH, topBlockHeight)];
	topBlock.physicsBody.categoryBitMask = blockBitMask;
	topBlock.physicsBody.contactTestBitMask = birdBitMask;
	
}

- (float) randomFloatBetween:(float) min and:(float) max{
    
    float random =  ((rand()%RAND_MAX)/(RAND_MAX*1.0))*(max-min)+min;
    return random;
}

#pragma mark - User Interaction
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if (isGameOver) {
		[self startGame];
		return;
	}
	
	if (!bird.physicsBody) {
		[self.view endEditing:YES];
		
		if ([self.delegate respondsToSelector:@selector(gameOver)]) {
			[self.delegate gameOver];
		}
		[bird startPlay];
	}
	
	[bird jumpBird];
}

#pragma mark - Update
- (void) update:(NSTimeInterval)currentTime {
	if (isGameOver) {
		return;
	}
	[floor	update:currentTime];
	[city	update:currentTime];
	[clouds update:currentTime];
	[bird	update:currentTime];
	[self   updateBlocks:currentTime];
	[self   updateScore:currentTime];
}

- (void) updateBlocks:(NSTimeInterval)currentTime {
	if (!bird.physicsBody) {
		return;
	}
	
	for (int i = 0; i < nbObstacles; i++) {
		PipeNode *topPipe = (PipeNode*)topPipes[i];
		PipeNode *bottomPipe = (PipeNode*)bottomPipes[i];
		if (topPipe.position.x < -topPipe.size.width) {
			PipeNode *mostRightPipe = (PipeNode*)topPipes[(i + (nbObstacles - 1))% nbObstacles];
			[self place:topPipe and:bottomPipe atX:mostRightPipe.position.x + BLOCK_WIDTH + BLOCK_INTERVAL_SPACE];
		}
		topPipe.position = CGPointMake(topPipe.position.x - FLOOR_SCROLLING_SPEED, topPipe.position.y);
		bottomPipe.position = CGPointMake(bottomPipe.position.x - FLOOR_SCROLLING_SPEED, bottomPipe.position.y);
	}
}
- (void) updateScore:(NSTimeInterval)currentTime {
	for (int i = 0 ; i < nbObstacles; i++) {
		PipeNode *topPipe = (PipeNode*)topPipes[i];
		
		if (topPipe.frame.origin.x + BLOCK_WIDTH > CGRectGetMidX(self.frame) &&
			topPipe.frame.origin.x + BLOCK_WIDTH < CGRectGetMidX(self.frame) + FLOOR_SCROLLING_SPEED) {
			score += 1;
			sklblScoreBG.text = [NSString stringWithFormat:@"%d", score];
			if (score >= 10) {
				sklblScoreBG.fontSize = 340;
				sklblScoreBG.position = CGPointMake(CGRectGetMidX(self.frame), 120);
			}
			if (score >= 100) {
				sklblScoreBG.fontSize = 200;
				sklblScoreBG.position = CGPointMake(CGRectGetMidX(self.frame), 160);
			}
		}
	}
}
#pragma mark - Physic

- (void)didBeginContact:(SKPhysicsContact *)contact {
	if (isGameOver) {
		return;
	}
	
	isGameOver = YES;
	
	[Score registerScore:score];
	
	if ([self.delegate respondsToSelector:@selector(gameOver)]) {
		[self.delegate gameOver];
	}
}
@end
