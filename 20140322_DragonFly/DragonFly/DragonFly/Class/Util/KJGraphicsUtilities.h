//
//  KJGraphicsUtilities.h
//  shooting
//
//  Created by Dunkey on 2013. 11. 8..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

//#import <Foundation/Foundation.h>
//
//@interface KJGraphicsUtilities : NSObject
//
//@end


/* Generate a random float between 0.0f and 1.0f. */
#define KJ_RANDOM_0_1() (arc4random() / (float)(0xffffffffu))

/* The assets are all facing Y down, so offset by pi half to get into X right facing. */
#define KJ_POLAR_ADJUST(x) x + (M_PI * 0.5f)


/* Load an array of KJDataMap or KJTreeMap structures for the given map file name. */
void *KJCreateDataMap(NSString *mapName);

/* Distance and coordinate utility functions. */
CGFloat KJDistanceBetweenPoints(CGPoint first, CGPoint second);
CGFloat KJRadiansBetweenPoints(CGPoint first, CGPoint second);
CGPoint KJPointByAddingCGPoints(CGPoint first, CGPoint second);

/* Load the named frames in a texture atlas into an array of frames. */
NSArray *KJLoadFramesFromAtlas(NSString *atlasName, NSString *baseFileName, int numberOfFrames);

/* Run the given emitter once, for duration. */
void KJRunOneShotEmitter(SKEmitterNode *emitter, CGFloat duration);


/* Define structures that map exactly to 4 x 8-bit ARGB pixel data. */
#pragma pack(1)
typedef struct {
    uint8_t bossLocation, wall, goblinCaveLocation, heroSpawnLocation;
} KJDataMap;

typedef struct {
    uint8_t unusedA, bigTreeLocation, smallTreeLocation, unusedB;
} KJTreeMap;
#pragma pack()

typedef KJDataMap *KJDataMapRef;
typedef KJTreeMap *KJTreeMapRef;


/* Category on NSValue to make it easy to access the pointValue/CGPointValue from iOS and OS X. */
@interface NSValue (KJAdventureAdditions)
- (CGPoint)kj_CGPointValue;
+ (instancetype)kj_valueWithCGPoint:(CGPoint)point;
@end


/* Category on SKEmitterNode to make it easy to load an emitter from a node file created by Xcode. */
@interface SKEmitterNode (KJAdventureAdditions)
+ (instancetype)kj_emitterNodeWithEmitterNamed:(NSString *)emitterFileName;
@end