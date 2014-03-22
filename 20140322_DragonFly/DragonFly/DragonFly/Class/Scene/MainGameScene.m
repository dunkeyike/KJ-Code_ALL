//
//  MyScene.m
//  shooting
//
//  Created by Dunkey on 2013. 11. 7..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "MainGameScene.h"
#import "BackGroundImage.h"
#import "KJFlyPlayer.h"
#import "GameHud.h"
#import "KJBossEnemyCharacter.h"

@interface MainGameScene() <SKPhysicsContactDelegate> {
	NSMutableArray *arrBoss;
}
@property (nonatomic) KJFlyPlayer       *player;
@property (nonatomic) NSTimeInterval    lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval    lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval    lastbulletTimeInterval;
@property (nonatomic) NSTimeInterval    lastbulletUpdateTimeInterval;
@property (nonatomic) int               monsterDestroyed;
@property (nonatomic) BOOL              isBossMode;
@property (nonatomic) BackGroundImage   *bgImg1;
@property (nonatomic) BackGroundImage   *bgImg2;
@property (nonatomic) GameHud           *gameHud;
@property (nonatomic, assign) NSInteger intScore;
@end

static const uint32_t playerCategory            = 0x1 << 0;
static const uint32_t monsterCategory           = 0x1 << 1;
static const uint32_t bulletCategory            = 0x1 << 2;
static const uint32_t bossCategory				= 0x1 << 3;

// 벡터 계산 인라인 함수
static inline CGPoint rwAdd(CGPoint a, CGPoint b) {
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint rwSub(CGPoint a, CGPoint b) {
    return CGPointMake(a.x - b.x, a.y - b.y);
}

static inline CGPoint rwMulti(CGPoint a, float b) {
    return CGPointMake(a.x * b, a.y * b);
}

static inline float rwLength (CGPoint a) {
    return sqrtf(a.x * a.x + a.y * a.y);
}

static inline CGPoint rwNormalize (CGPoint a) {
    float length = rwLength(a);
    return CGPointMake(a.x / length, a.y / length);
}


@implementation MainGameScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.isBossMode = NO;
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        _bgImg1 = [BackGroundImage spriteNodeWithImageNamed:@"bg_01.png"];
        _bgImg1.size = self.size;
        _bgImg1.anchorPoint = CGPointZero;
        _bgImg1.position = CGPointMake(0, _bgImg1.size.height);
        _bgImg1.zPosition = -1;
        [self addChild:_bgImg1];

        _bgImg2 = [BackGroundImage spriteNodeWithImageNamed:@"bg_01.png"];
        _bgImg2.size = self.size;
        _bgImg2.anchorPoint = CGPointZero;
        _bgImg2.position = CGPointMake(0, self.size.height);
        _bgImg2.zPosition = -1;
        [self addChild:_bgImg2];
        
        _bgImg1.position = CGPointZero;
        _bgImg2.position = CGPointMake(0, _bgImg2.size.height);

        _gameHud = [GameHud node];
        [_gameHud setupNode];
        _gameHud.zPosition = 5;
        [self addChild:_gameHud];
        
        self.player = [KJFlyPlayer spriteNodeWithImageNamed:@"player.png"];
        self.player.position = CGPointMake(self.size.width/2, 100);
        self.player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.player.size.width/4, self.player.size.height/4)];
        self.player.physicsBody.dynamic = YES;
        self.player.physicsBody.categoryBitMask  = playerCategory;
        self.player.physicsBody.contactTestBitMask  = monsterCategory | bossCategory;
        self.player.physicsBody.collisionBitMask = 0;
        self.player.physicsBody.usesPreciseCollisionDetection = YES;
        
        [self addChild:self.player];
        
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
		
		_intScore = 0;
		
		arrBoss = [[NSMutableArray alloc] init];
    }
    return self;
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    self.player.position = CGPointMake(location.x, location.y);
}

-(void)update:(CFTimeInterval)currentTime {
    CGPoint currPos = _bgImg1.position;
    
    if (currPos.y < -self.size.height) {
        _bgImg1.position = CGPointZero;
        currPos = CGPointMake(0, _bgImg2.size.height);
        _bgImg2.position = currPos;
    } else {
        _bgImg1.position = CGPointMake(_bgImg1.position.x, _bgImg1.position.y - 3);
        _bgImg2.position = CGPointMake(_bgImg2.position.x, _bgImg2.position.y - 3);
    }
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 0.5) {
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    [self updateWithTimeIntervalLastUpdate:timeSinceLast];
    
}

- (void) updateWithTimeIntervalLastUpdate:(CFTimeInterval)timeSinceLast {
    self.lastSpawnTimeInterval += timeSinceLast;
    self.lastbulletTimeInterval += timeSinceLast;
	
	if (self.isBossMode) {
		if (self.lastSpawnTimeInterval > 1.5) {
			self.lastSpawnTimeInterval = 0;
			[self addBoss];
		}
		
	} else {
		if (self.lastSpawnTimeInterval > 0.5) {
			self.lastSpawnTimeInterval = 0;
			[self addMonster];
		}
	}
    if (self.lastbulletTimeInterval > 0.1) {
        self.lastbulletTimeInterval = 0;
        [self addBullet];
    }
}

- (void) addMonster {
    SKSpriteNode *monster = [SKSpriteNode spriteNodeWithImageNamed:@"enemy_small.png"];
    
    monster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:monster.size];
    monster.physicsBody.dynamic = YES;
    monster.physicsBody.categoryBitMask = monsterCategory;
    monster.physicsBody.contactTestBitMask = bulletCategory | playerCategory;
    monster.physicsBody.collisionBitMask = 0;
    
    int minX = monster.size.width/2;
    int maxX = self.frame.size.width - monster.size.width/2;
    int rangeX = maxX - minX;
    int actualX = (arc4random()%rangeX) + minX;
    
    monster.position = CGPointMake(actualX, self.frame.size.height + monster.size.height/2);
    [self addChild:monster];

    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random()%rangeDuration) + minDuration;
    
    SKAction *actionMove = [SKAction moveTo:CGPointMake(actualX , -monster.size.width/2 ) duration:actualDuration];
    SKAction *actionMoveDone = [SKAction removeFromParent];
    [monster runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    
//    SKAction *loseAction = [SKAction runBlock:^{
//        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
//        SKScene *gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:NO];
//        [self.view presentScene:gameOverScene transition:reveal];
//    }];
//    [monster runAction:[SKAction sequence:@[actionMove, loseAction, actionMoveDone]]];
}

-(void) addBullet {
    SKSpriteNode *bullet = [SKSpriteNode spriteNodeWithImageNamed:@"bullet_01.png"];
    bullet.position = CGPointMake(self.player.position.x, self.player.position.y + 50);
    
    bullet.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(bullet.size.width/2, bullet.size.height/2)];
    bullet.physicsBody.dynamic = YES;
    bullet.physicsBody.categoryBitMask  = bulletCategory;
    bullet.physicsBody.contactTestBitMask  = monsterCategory | bossCategory;
    bullet.physicsBody.collisionBitMask = 0;
    bullet.physicsBody.usesPreciseCollisionDetection = YES;
    
    [self addChild:bullet];
    
    CGPoint offset = rwSub(CGPointMake(bullet.position.x, 1000), bullet.position);
    CGPoint direction = rwNormalize(offset);
    CGPoint shootAmount = rwMulti(direction, 1000);
    CGPoint realDest = rwAdd(shootAmount, bullet.position);
    
    float velocity = 480.0 / 1.0;
    float realMoveDuration = self.size.width / velocity;
    
    SKAction *actionMove = [SKAction moveTo:realDest duration:realMoveDuration];
    SKAction *actionMoveDone = [SKAction removeFromParent];
    [bullet runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    [self runAction:[SKAction playSoundFileNamed:@"se_attack.wav" waitForCompletion:NO]];
}
- (void) addBoss {
	SKSpriteNode *monster = [SKSpriteNode spriteNodeWithImageNamed:@"boss.png"];
    monster.size = CGSizeMake(self.size.width/2, self.size.height/2);
    
    monster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:monster.size];
    monster.physicsBody.dynamic = YES;
    monster.physicsBody.categoryBitMask = monsterCategory;
    monster.physicsBody.contactTestBitMask = bulletCategory | playerCategory;
    monster.physicsBody.collisionBitMask = 0;
    
    int minX = monster.size.width/2;
    int maxX = self.frame.size.width - monster.size.width/2;
    int rangeX = maxX - minX;
    int actualX = (arc4random()%rangeX) + minX;
    
    monster.position = CGPointMake(actualX, self.frame.size.height + monster.size.height/2);
    [self addChild:monster];
    
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random()%rangeDuration) + minDuration;
    
    SKAction *actionMove = [SKAction moveTo:CGPointMake(actualX , -monster.size.width/2 ) duration:actualDuration];
    SKAction *actionMoveDone = [SKAction removeFromParent];
    [monster runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];

	
	NSMutableDictionary *dicBoss = [[NSMutableDictionary alloc] init];
	[dicBoss setObject:monster forKey:@"boss"];
	[dicBoss setObject:[NSNumber numberWithInt:100] forKey:@"hp"];
	[arrBoss addObject:dicBoss];
	
}
-(void) collisionWithBullet:(SKSpriteNode *)bullet fromMonster:(SKSpriteNode *)monster {
    self.monsterDestroyed++;
    if (self.monsterDestroyed > 5) {
        self.isBossMode = YES;
    }
	_intScore += 10;
	_gameHud.lblScore.text = [NSString stringWithFormat:@"SCORE : %ld", (long)_intScore];
    NSString *myParticlePath = [[NSBundle mainBundle] pathForResource:@"spark" ofType:@"sks"];
    SKEmitterNode *myParticle = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
    myParticle.particlePosition = bullet.position;
//    myParticle.particleBirthRate = 5;
    [self addChild:myParticle];
//    myParticle.particleLifetime = 0.5;
    [self performSelector:@selector(removeSpark) withObject:Nil afterDelay:0.5];
//    [self removeSpark];
    [self runAction:[SKAction playSoundFileNamed:@"baby_dragon_die.wav" waitForCompletion:NO]];
    [bullet removeFromParent];
    [monster removeFromParent];
}

-(void) collisionWithBullet:(SKSpriteNode *)bullet fromBoss:(SKSpriteNode *)boss {
	
	for (NSMutableDictionary *dic in arrBoss) {
		if ([dic objectForKey:@"boss"] == boss) {
			NSLog(@"bossbossbossbossbossbossbossbossboss");
		}
	}
//	KJBossEnemyCharacter *bossMonster = (KJBossEnemyCharacter*)boss;
//	bossMonster.hp -= 10;
//	if (boss.hp < 0) {
		_intScore += 100;
		_gameHud.lblScore.text = [NSString stringWithFormat:@"SCORE : %ld", (long)_intScore];
		NSString *myParticlePath = [[NSBundle mainBundle] pathForResource:@"spark" ofType:@"sks"];
		SKEmitterNode *myParticle = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
		myParticle.particlePosition = bullet.position;
		//    myParticle.particleBirthRate = 5;
		[self addChild:myParticle];
		//    myParticle.particleLifetime = 0.5;
		[self performSelector:@selector(removeSpark) withObject:Nil afterDelay:0.5];
		//    [self removeSpark];
		[self runAction:[SKAction playSoundFileNamed:@"baby_dragon_die.wav" waitForCompletion:NO]];
		[bullet removeFromParent];
		[boss removeFromParent];
		
//	}
}

- (void) removeSpark {
    for (SKEmitterNode *sks in [self children]) {
        if ([sks isKindOfClass:[SKEmitterNode class]]) {
            SKAction *alphaRemove = [SKAction fadeOutWithDuration:0.5];
            SKAction *remove = [SKAction removeFromParent];
            [sks runAction:[SKAction sequence:@[alphaRemove, remove]]];
        }
    }
}
-(void) collisionWithPlayer:(SKSpriteNode *)player fromMonster:(SKSpriteNode *)monster {
    NSLog(@"Hit");
	NSString *myParticlePath = [[NSBundle mainBundle] pathForResource:@"hit" ofType:@"sks"];
    SKEmitterNode *myParticle = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
    myParticle.particlePosition = player.position;
	//    myParticle.particleBirthRate = 5;
    [self addChild:myParticle];
	[self performSelector:@selector(removeSpark) withObject:Nil afterDelay:0.5];

}

-(void) didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    NSLog(@"%s", __FUNCTION__);
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ((firstBody.categoryBitMask & playerCategory) != 0 &&
        (secondBody.categoryBitMask & monsterCategory) != 0) {
        [self collisionWithPlayer:(SKSpriteNode*)firstBody.node fromMonster:(SKSpriteNode *)secondBody.node];
    }
    
    
    if ((firstBody.categoryBitMask & monsterCategory) != 0 &&
        (secondBody.categoryBitMask & bulletCategory) != 0) {
		if (self.isBossMode) {
			[self collisionWithBullet:(SKSpriteNode*)firstBody.node fromBoss:(SKSpriteNode *)secondBody.node];
		} else {
		    [self collisionWithBullet:(SKSpriteNode*)firstBody.node fromMonster:(SKSpriteNode *)secondBody.node];
			
		}
        
    }
	
	if ((firstBody.categoryBitMask & bossCategory) != 0 &&
        (secondBody.categoryBitMask & bulletCategory) != 0) {
		[self collisionWithBullet:(SKSpriteNode*)firstBody.node fromBoss:(SKSpriteNode *)secondBody.node];
    }
}

@end
