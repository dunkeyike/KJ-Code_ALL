//
//  LineChartView.h
//  LineChartSample
//
//  Created by Lee jaeeun on 2014/02/22.
//  Copyright (c) 2014年 kjcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LineChartViewDelegate;

@interface LineChartView : UIView

@property (nonatomic) id<LineChartViewDelegate> delegate;

@property (nonatomic,readonly) NSInteger cnt;           //外部から変更できないようにreadonly
@property (nonatomic, strong,readonly) UIColor *color;  //外部から変更できないようにreadonly

//Xibを利用したインスタンス生成メソッド
+ (id)createView:(UIView *)baseView;

//ビューの再ロード
- (void)reloadLineChartView;

@end

//データのやり取りのためにプロトコルを作成
@protocol LineChartViewDelegate <NSObject>

//値を受け取るためにデリゲートメソッドを作成

//描画が終わったら通知するメソッド
- (void)lineChartViewPointDrawFinished:(LineChartView *)chartView;

//描画をするポイントの情報を委任する
- (NSInteger)lineChartPointCount;
- (UIColor *)lineChartPointColor;

@end