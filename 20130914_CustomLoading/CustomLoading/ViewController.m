//
//  ViewController.m
//  CustomLoading
//
//  Created by IKE on 13. 7. 31..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
	self.rootLayer = [CALayer layer];
	self.rootLayer.frame = self.view.bounds;
	UIImageView *ivFrame = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"10_hud_spinner_userframe"]];
	ivFrame.center = self.view.center;
	
	// 프로필 사진을 둥굴게 만듬
	UIImage *image = [UIImage imageNamed:@"10_hud_acitvePlaceHolder_1.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	imageView.layer.cornerRadius = 65;
	imageView.layer.masksToBounds = YES;
	imageView.center = self.view.center;
	
	
	// 주황색 원 레이어 설정
	UIImage	*image2 = [UIImage imageNamed:@"10_hud_spinner_glow.png"];
	CALayer *layer = [CALayer layer];
	layer.contents = (id)image2.CGImage;
	layer.bounds = CGRectMake(0, 0, image2.size.width, image2.size.height);
	layer.position = self.view.center;
	layer.transform = CATransform3DMakeScale(0.90, 0.90, 1);
	[self.rootLayer addSublayer:layer];
	
	// 첫번째 반원 레이어 설정
	UIImage	*image3 = [UIImage imageNamed:@"10_hud_spinner_white.png"];
	CALayer *layer2 = [CALayer layer];
	layer2.contents = (id)image3.CGImage;
	layer2.bounds = CGRectMake(0, 0, image3.size.width, image3.size.height);
	layer2.position = self.view.center;
	layer2.transform = CATransform3DMakeScale(1.0, 1.0, 1);
	[self.rootLayer addSublayer:layer2];
	
	// 두번째 반원 레이어 설정
	UIImage	*image4 = [UIImage imageNamed:@"10_hud_spinner_white2.png"];
	CALayer *layer3 = [CALayer layer];
	layer3.contents = (id)image4.CGImage;
	layer3.bounds = CGRectMake(0, 0, image4.size.width, image4.size.height);
	layer3.position = self.view.center;
	layer3.shouldRasterize = YES;
	layer3.transform = CATransform3DMakeScale(0.75, 0.75, 1);
	[self.rootLayer addSublayer:layer3];
	
	
	// 에니메이션 설정
	// 펄스 에니메이션 (꽁딱꽁딱~~)
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
	animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	animation.autoreverses = YES;
	animation.duration = 0.35;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	animation.repeatCount = HUGE_VALF;
	// 애니메이션 적용
	[layer addAnimation:animation forKey:@"pulseAnimation"];
	[layer2 addAnimation:animation forKey:@"pulseAnimation"];
	[layer3 addAnimation:animation forKey:@"pulseAnimation"];
	
	
	// 회전 에니메이션 반시계방향
	CABasicAnimation  *rotate;
	rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	rotate.fromValue = [NSNumber numberWithFloat:0];
	rotate.toValue = [NSNumber numberWithFloat:360];
	rotate.fillMode = kCAFillModeForwards;
	rotate.duration = 60.35;
	rotate.autoreverses = YES;
	rotate.repeatCount = HUGE_VALF;
	rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	
	// 회전 에니메이션 시계방향
	CABasicAnimation  *rotate2;
	rotate2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	rotate2.fromValue = [NSNumber numberWithFloat:360];
	rotate2.toValue = [NSNumber numberWithFloat:0];
	rotate2.fillMode = kCAFillModeForwards;
	rotate2.duration = 100.35;
	rotate2.autoreverses = YES;
	rotate2.repeatCount = HUGE_VALF;
	rotate2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	
	
	// 빤짝 에니메이션1
	CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
	flash.fromValue = [NSNumber numberWithFloat:0.0];
	flash.toValue = [NSNumber numberWithFloat:1.0];
	flash.duration = 1.0;
	flash.autoreverses = YES;
	flash.repeatCount = HUGE_VALF;
	
	// 빤짝 에니메이션2
	CABasicAnimation *flash2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
	flash2.fromValue = [NSNumber numberWithFloat:1.0];
	flash2.toValue = [NSNumber numberWithFloat:0.3];
	flash2.duration = 0.6;        // 1 second
	flash2.autoreverses = YES;		// Back
	flash2.repeatCount = HUGE_VALF;       // Or whatever
	
	
	// 각각의 에니메이션을 레이어에 적용
	[layer2 addAnimation:rotate forKey:@"rotateAnimation"];
	[layer3 addAnimation:rotate2 forKey:@"rotateAnimation"];
	
	[layer2 addAnimation:flash forKey:@"flashAnimation"];
	[layer3 addAnimation:flash2 forKey:@"flashAnimation"];
	
	[self.view.layer addSublayer:self.rootLayer];
	
	[self.view addSubview: imageView];
	[self.view addSubview:ivFrame];
	[self.view bringSubviewToFront:ivFrame];

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
