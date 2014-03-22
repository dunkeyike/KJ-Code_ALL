//
//  KJPlayer.m
//  shooting
//
//  Created by Dunkey on 2013. 11. 8..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "KJPlayer.h"

@implementation KJPlayer

#pragma mark - Initialization
- (id)init {
    self = [super init];
    if (self) {
        _livesLeft = kStartLives;
        _playerClass = NSClassFromString(@"KJFlyPlayer");
    }
    return self;
}

@end
