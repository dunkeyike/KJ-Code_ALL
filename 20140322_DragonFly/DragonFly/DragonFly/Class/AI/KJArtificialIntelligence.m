//
//  KJArtificialIntelligence.m
//  shooting
//
//  Created by Dunkey on 2013. 11. 8..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "KJArtificialIntelligence.h"

@implementation KJArtificialIntelligence

#pragma mark - Initialization
- (id)initWithCharacter:(KJCharacter *)character target:(KJCharacter *)target {
    self = [super init];
    if (self) {
        _character = character;
        _target = target;
    }
    return self;
}

#pragma mark - Loop Update
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)interval {
    /* Overridden by subclasses. */
}

#pragma mark - Targets
- (void)clearTarget:(KJCharacter *)target {
    if (self.target == target) {
        self.target = nil;
    }
}

@end
