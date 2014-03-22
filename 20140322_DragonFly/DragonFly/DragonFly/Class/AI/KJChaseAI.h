//
//  KJChaseAI.h
//  shooting
//
//  Created by Dunkey on 2013. 11. 8..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "KJArtificialIntelligence.h"

#define kEnemyAlertRadius (kCharacterCollisionRadius * 100)

@interface KJChaseAI : KJArtificialIntelligence

@property (nonatomic) CGFloat chaseRadius;
@property (nonatomic) CGFloat maxAlertRadius;

@end
