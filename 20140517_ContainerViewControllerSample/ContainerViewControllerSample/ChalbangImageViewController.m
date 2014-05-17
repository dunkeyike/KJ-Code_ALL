//
//  ChalbangImageViewController.m
//  ContainerViewControllerSample
//
//  Created by Lee jaeeun on 2014/05/16.
//  Copyright (c) 2014年 kjcode. All rights reserved.
//

#import "ChalbangImageViewController.h"
#import "ViewController.h"

@interface ChalbangImageViewController ()

@end

@implementation ChalbangImageViewController

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
    NSLog(@"%s", __FUNCTION__);
}
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
}
- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
}
- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
}
- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
