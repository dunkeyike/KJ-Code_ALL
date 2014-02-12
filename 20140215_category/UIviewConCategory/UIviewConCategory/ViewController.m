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

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor blendedColorWithForegroundColor:[UIColor user_waterColor] backgroundColor:[UIColor user_lightPinkColor] percentBlend:0.8];
	self.view.tintColor = [UIColor redColor];
	
	self.imageView.image = [UIImage imageNamed:@"DisplayImage"];
	
	UILabel *lblTest = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 0)];
	lblTest.layer.borderWidth = 2;
	lblTest.layer.borderColor = [UIColor redColor].CGColor;
	lblTest.textColor = [UIColor redColor];
	lblTest.text = @"k;asjdf;klasdjf;alksdjfal;skdfjkasdfljkasdhfljkasdhlfakjsdhflaskdjfhalsdkfjhalsdkfjhalsdkjfhalsdfkjhasldfkjhasldfkjahsdlfjakhsdflasjdkfhalsdkjfhalsdkfjhasdlfkjh";
	[lblTest autosizeForWidth:lblTest.frame.size.width];
	lblTest.center = self.view.center;
	[self.view addSubview:lblTest];
	// use NSUserDefault Category
	[NSUserDefaults setUserName:@"DunkeyDev"];
	[NSUserDefaults sync];
	
	// use default NSUserDefault
	[[NSUserDefaults standardUserDefaults]setObject:@"DunkeyDev" forKey:@"userName_Temp"];
	[[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onShowOverlayView:(id)sender {
	[self showBlurLayer:@"MESSAGE To SHOW!!!!"];
}
@end
