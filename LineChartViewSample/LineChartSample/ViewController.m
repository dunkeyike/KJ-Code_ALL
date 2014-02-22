//
//  ViewController.m
//  LineChartSample
//
//  Created by Lee jaeeun on 2014/02/22.
//  Copyright (c) 2014年 kjcode. All rights reserved.
//

#import "ViewController.h"
#import "LineChartView.h"

@interface ViewController ()<LineChartViewDelegate> {
    
    IBOutlet UIView *lineChartContainerView;
    LineChartView *_lineChartView;
    
}

- (IBAction)buttonTounched:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
//    [Util myMethod:@"test"];
    
    _lineChartView = [LineChartView createView:lineChartContainerView];
    _lineChartView.delegate = self;
    
    
//    [_lineChartView setNeedsDisplay];
    
//    _lineChartView.cnt = 5;
//    _lineChartView.color = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)buttonTounched:(id)sender {
    NSLog(@"%s",__FUNCTION__);
    [_lineChartView reloadLineChartView];
}

#pragma mark - delegate methods
- (void)lineChartViewPointDrawFinished:(LineChartView *)chartView {
    NSLog(@"%s",__FUNCTION__);
    
}

- (NSInteger)lineChartPointCount {
    NSLog(@"%s",__FUNCTION__);
    //描画ポイントの数を設定
    return 10;
}

- (UIColor *)lineChartPointColor {
    //描画ポイント色指定
    return [UIColor redColor];
}

//プロトコルによって実装するメソッド
- (void)loadModel {
    NSLog(@"%s",__FUNCTION__);
}


@end
