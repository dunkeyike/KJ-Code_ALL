//
//  KJBossEnemyCharacter.h
//  shooting
//
//  Created by Dunkey on 2013. 11. 8..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "KJEnemyCharacter.h"

@interface KJBossEnemyCharacter : SKSpriteNode {
	NSInteger hp;
}
@property(nonatomic, assign) NSInteger hp;
-(void) setupBoss;

@end
