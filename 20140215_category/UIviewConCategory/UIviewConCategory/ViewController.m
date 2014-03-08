//
//  ViewController.m
//  UIviewConCategory
//
//  Created by Dunkey on 2014. 2. 6..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+OverlayView.h"
#import "UIColor+UserDefineColor.h"
#import "UILabel+AutoSize.h"
#import "NSUserDefaults+Addition.h"
#import "UIView+ScreenShot.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// make blend color with 2 colors with use UIColor+UserDefineColor
	self.view.backgroundColor = [UIColor blendedColorWithForegroundColor:[UIColor user_waterColor] backgroundColor:[UIColor user_lightPinkColor] percentBlend:0.8];
	self.view.tintColor = [UIColor redColor];
	
	// test UILabel
	UILabel *lblTest = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 0)];
	lblTest.textColor = [UIColor KJ_GreenColor];
	lblTest.text = @"今日はiOS Objective-Cの文法のカテゴリについて説明をしました。\n오늘은 iOS Objective-C문법중 카테고리에 대해서 설명했습니다. \nToday we learn Objective-C Category synax";

	// auto size with UILabel+AutoSize
	[lblTest autosizeForWidth:lblTest.frame.size.width];
	lblTest.center = self.view.center;
	[self.view addSubview:lblTest];
	
	// use NSUserDefaults+Addition Category
	[NSUserDefaults setUserName:@"DunkeyDev"];
	[NSUserDefaults sync];
	[[NSUserDefaults standardUserDefaults] setObject:@"dunkey" forKey:@"UserNAme"];
	
	// use default NSUserDefault
	[[NSUserDefaults standardUserDefaults]setObject:@"DunkeyDev" forKey:@"userName_Temp"];
	[[NSUserDefaults standardUserDefaults]synchronize];
	
	UIImage *tempImage = [[UIImage alloc] init];
	tempImage = [self.view screenshot];
}

- (IBAction)onShowOverlayView:(id)sender {
	// senf message to self category instance method
	[self showBlurLayer:@"MESSAGE To SHOW!!!!"];
}

- (void) showLog {
	
}
@end


