//
//  ThirdViewController.m
//  Notificatiion
//
//  Created by Dunkey on 2013. 11. 15..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onBlue:(id)sender {
	NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[UIColor blueColor],@"NaviBarColor",[UIColor blackColor], @"TintColor", nil];
	
	[[NSNotificationCenter defaultCenter]postNotificationName:@"changeNaviColor" object:dic];
}
-(IBAction)onRed:(id)sender {
	NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[UIColor redColor],@"NaviBarColor",[UIColor orangeColor], @"TintColor", nil];
	[[NSNotificationCenter defaultCenter]postNotificationName:@"changeNaviColor" object:dic];
}
-(IBAction)onYellow:(id)sender {
	NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[UIColor yellowColor],@"NaviBarColor",[UIColor purpleColor], @"TintColor", nil];
	[[NSNotificationCenter defaultCenter]postNotificationName:@"changeNaviColor" object:dic];
}
@end
