//
//  SecondViewController.m
//  Notificatiion
//
//  Created by Dunkey on 2013. 11. 15..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

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

- (IBAction)onOneBtn:(id)sender {
	[[NSNotificationCenter defaultCenter]postNotificationName:@"toggleOne" object:nil];
}
- (IBAction)onTwoBtn:(id)sender {
	[[NSNotificationCenter defaultCenter]postNotificationName:@"toggleTwo" object:nil];
}
- (IBAction)onThreeBtn:(id)sender {
	[[NSNotificationCenter defaultCenter]postNotificationName:@"toggleThree" object:nil];
}


@end
