//
//  KJChaseAI.m
//  shooting
//
//  Created by Dunkey on 2013. 11. 8..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "KJChaseAI.h"
#import "KJCharacter.h"
#import "KJGraphicsUtilities.h"
#import "KJPlayer.h"
//#import "KJMultiplayerLayeredCharacterScene.h"
#import "KJPlayerCharacter.h"

@implementation KJChaseAI
#pragma mark - Initialization
- (id)initWithCharacter:(KJCharacter *)character target:(KJCharacter *)target {
    self = [super initWithCharacter:character target:target];
    if (self) {

    }
    return self;
}

#pragma mark - Loop Update
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)interval {
    
}
@end
