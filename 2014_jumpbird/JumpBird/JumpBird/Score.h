//
//  Score.h
//  JumpBird
//
//  Created by Dunkey on 2014. 2. 18..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject

// 게임이 끝날때마다 점수 저장
+ (void) registerScore:(NSInteger)score;

// 최고점수를 NSUserDefault에 저장
+ (void) setBestScore:(NSInteger)bestScore;

// NSUserDefault에 저장된 최고점수 가져오기
+ (NSInteger)getBestScore;
@end
