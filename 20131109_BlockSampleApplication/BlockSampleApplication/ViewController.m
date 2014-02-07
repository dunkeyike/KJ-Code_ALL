//
//  ViewController.m
//  BlockSampleApplication
//
//  Created by Lee jaeeun on 2013/11/09.
//  Copyright (c) 2013年 kjcode. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)test1:(id)sender;
- (IBAction)test2:(id)sender;
- (IBAction)test3:(id)sender;
@end

@implementation ViewController

//typedef     int (^test)(int);

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //delegate를 사용
    self.man = [Human new];
    _man.delegate = self;
    
    //selector를 이용
    self.woman = [[Human alloc] initWithTarget:self action:@selector(actionComplete:)];
    
    //block를 이용
    self.gay = [Human new];
    
//    test aaa = ^(int x) {
//        return x+x;
//    };
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)test1:(id)sender {
    //delegate
    [_man doEat];
}

- (IBAction)test2:(id)sender {
    
    //selector
    [_woman eat:@"aaa"];
}

- (IBAction)test3:(id)sender {
    
    //block
    
    [_gay eat:@"お寿司" complete:^{
        NSLog(@"test3 in block");
    }];
    
    [_gay sleep:^BOOL(int i, int j) {
        
        NSLog(@"param %d, %d",i,j);
        
        return YES;
    }];
    
    
}


#pragma mark - Human delegate method
- (void)human:(Human *)obj compelte:(BOOL)on {
    NSLog(@"%s",__FUNCTION__);
    
    //TODO:
}

#pragma mark - callback method
- (void)actionComplete:(NSString *)str {
     NSLog(@"%s, %@",__FUNCTION__,str);
    
    //TODO:
}

@end


