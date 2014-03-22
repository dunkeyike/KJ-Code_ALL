//
//  KJArtificialIntelligence.h
//  shooting
//
//  Created by Dunkey on 2013. 11. 8..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KJCharacter;

@interface KJArtificialIntelligence : NSObject

@property (nonatomic, weak) KJCharacter *character;
@property (nonatomic, weak) KJCharacter *target;

- (id) initWithCharacter:(KJCharacter *)character target:(KJCharacter *)target;
- (void) clearTarget:(KJCharacter *)target;
- (void) updateWithTimeSinceLastUpdate:(CFTimeInterval)interval;
@end
