//
//  Score.m
//  JumpBird
//
//  Created by Dunkey on 2014. 2. 18..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "Score.h"

#define kBestScoreKey	@"BestScoreKey"

@implementation Score

// 게임이 끝날때마다 점수 저장
+ (void) registerScore:(NSInteger)score {
	// 현제 점수가 최고점수보다 크면 최고점수 갱신
	if (score > [Score getBestScore]) {
		[Score setBestScore:score];
	}
}

// 최고점수를 NSUserDefault에 저장
+ (void) setBestScore:(NSInteger)bestScore {
	[[NSUserDefaults standardUserDefaults]setInteger:bestScore forKey:kBestScoreKey];
	[[NSUserDefaults standardUserDefaults]synchronize];
}

// NSUserDefault에 저장된 최고점수 가져오기
+ (NSInteger)getBestScore {
	return [[NSUserDefaults standardUserDefaults]integerForKey:kBestScoreKey];
}

@end
