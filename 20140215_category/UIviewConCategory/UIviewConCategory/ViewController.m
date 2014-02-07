//
//  ViewController.m
//  UIviewConCategory
//
//  Created by Dunkey on 2014. 2. 6..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+OverlayView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}
- (void) onHideLayer {
	[self hideLayer];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onShowOverlayView:(id)sender {
	[self showLayer:@"MESSAGE To SHOW!!!!"];
	
//	[self performSelector:@selector(onHideLayer) withObject:nil afterDelay:3.0f];

}
@end
