//
//  Util.h
//  LineChartSample
//
//  Created by Lee jaeeun on 2014/02/22.
//  Copyright (c) 2014年 kjcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

//メッセージと一緒に表示させるたい時には..
+(void)myMethod:(NSString*)abc __attribute((deprecated("use myMethod: animated: method")));

//新しく作成したメソッドこれを使いさせたい。
+(void)myMethod:(NSString*)abc animated:animated;

//メッセージなしでdeprecated表示したい場合
+(void)myMethod2:(NSString*)abc __deprecated;


//프로퍼티도 같은 방식으로
@property (strong) NSObject *object __attribute((deprecated("use xxxx property")));

@end
