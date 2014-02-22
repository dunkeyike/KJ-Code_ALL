//
//  ViewController.h
//  LineChartSample
//
//  Created by Lee jaeeun on 2014/02/22.
//  Copyright (c) 2014年 kjcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJViewController.h"
#import "Util.h"

@interface ViewController : KJViewController <KJCodeProtocol>

//プロトコルによって実装する
@property (nonatomic) NSInteger index;

@end
