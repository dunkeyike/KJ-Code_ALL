//
//  ViewController.m
//  DragonFly
//
//  Created by Dunkey on 2013. 11. 11..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "ViewController.h"
#import "MainGameScene.h"
@import AVFoundation;


@interface ViewController ()
@property(nonatomic) AVAudioPlayer *bgmPlayer;
@end

@implementation ViewController

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    NSError *error;
    NSURL *bgmMusicURL = [[NSBundle mainBundle] URLForResource:@"bgm" withExtension:@"mp3"];
    self.bgmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:bgmMusicURL error:&error];
    self.bgmPlayer.numberOfLoops = -1;
    [self.bgmPlayer prepareToPlay];
    [self.bgmPlayer play];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsDrawCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [MainGameScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
