//
//  KJCodeProtocol.h
//  LineChartSample
//
//  Created by Lee jaeeun on 2014/02/22.
//  Copyright (c) 2014年 kjcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KJCodeProtocol <NSObject>

//必ず実装するように定義
@required
@property (nonatomic) NSInteger index;
- (void)loadModel;

@end
