//
//  ViewController.m
//  JumpBird
//
//  Created by Dunkey on 2014. 2. 18..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "ViewController.h"
#import "Score.h"
#import "Scene.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet SKView		*gameView;
@property (nonatomic, weak) IBOutlet UILabel	*lblBestScore;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// 게임 프레임 (초당 화면 갱신비율 Frame per second) 표시
	self.gameView.showsFPS = YES;
	// 게임 화면에 표시되는 SKNode갯수를 표시
	self.gameView.showsNodeCount = YES;
	
	// 게임씬 준비
	Scene *scene = [Scene sceneWithSize:self.gameView.bounds.size];
	scene.scaleMode = SKSceneScaleModeAspectFill;
//	scene.delegate = self;
	
	[self.gameView presentScene:scene];
	self.lblBestScore.text = [NSString stringWithFormat:@"Best Score : %d", [Score getBestScore]];
	
}
- (void) gameOver {
	UIView *flash = [[UIView alloc] initWithFrame:self.view.frame];
	flash.backgroundColor = [UIColor whiteColor];
	flash.alpha = 0.8f;
	[self.view.window addSubview:flash];
	[UIView animateWithDuration:0.8f animations:^{
		flash.alpha = 0;
	} completion:^(BOOL finished) {
		[flash removeFromSuperview];
	}];
	
	self.lblBestScore.text = [NSString stringWithFormat:@"Best Score : %d", [Score getBestScore]];
}
@end
