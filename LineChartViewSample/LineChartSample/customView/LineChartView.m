//
//  LineChartView.m
//  LineChartSample
//
//  Created by Lee jaeeun on 2014/02/22.
//  Copyright (c) 2014年 kjcode. All rights reserved.
//

#import "LineChartView.h"

@implementation LineChartView

//- (id)initWithCoder:(NSCoder *)aDecoder {
//    
//}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)createView:(UIView *)baseView {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"LineChartView" owner:nil options:nil];
    LineChartView *v = [views objectAtIndex:0];
    
    baseView.backgroundColor = [UIColor clearColor];
    
    [baseView addSubview:v];
    return v;
}

- (void)reloadLineChartView {
    //再描画
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //デリゲートして値を受け取る
    _cnt = [_delegate lineChartPointCount];
    _color = [_delegate lineChartPointColor];
    
    float x = 0;
    float y = 0;
    
    for (int i=0;i <_cnt;i++) {
//        x = rand()%100;
//        y = rand()%100;
        
        //はみ出さないように調整
        x = (rand()%(int)self.frame.size.width - 20);
        y = rand()%(int)self.frame.size.height - 20;
        if (x < 0) {
            x = 0;
        }
        if (y < 0) {
            y = 0;
        }
        
        //四角形の描画
        CGContextStrokeRect(context, CGRectMake(x,y,20,20));
        CGContextSetFillColorWithColor(context, _color.CGColor);
        CGContextFillRect(context, CGRectMake(x,y,20,20));
    }
    
    //描画が完了したら通知する
    [_delegate lineChartViewPointDrawFinished:self];
    
}


@end
