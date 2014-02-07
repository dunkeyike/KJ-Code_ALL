//
//  Human.m
//  BlockSampleApplication
//
//  Created by Lee jaeeun on 2013/11/09.
//  Copyright (c) 2013年 kjcode. All rights reserved.
//

#import "Human.h"

@implementation Human

- (id)initWithTarget:(id)target action:(SEL)action {

    self = [super init];
    
    if (self) {
        _tar = target;
        _sel = action;
    }
    
    return self;
}

- (void)doEat {
    [_delegate human:self compelte:YES];
}

- (void)eat:(NSString *)rice {
    NSLog(@"%s",__FUNCTION__);
    
    [_tar performSelector:_sel withObject:@"eat!" afterDelay:0.0f];
}

- (void)sleep {
    NSLog(@"%s",__FUNCTION__);

    [_tar performSelector:_sel withObject:@"sleep..." afterDelay:0.0f];
}

- (void)work {
    NSLog(@"%s",__FUNCTION__);
    
    [_tar performSelector:_sel withObject:@"work?" afterDelay:0.0f];
}

- (void)eat:(NSString *)rice complete:(void(^)(void))handler {
    NSLog(@"%s",__FUNCTION__);
    
    handler();
}

- (void)sleep:(BOOL(^)(int,int))handler {
    NSLog(@"%s",__FUNCTION__);
    
    BOOL ret = handler(1, 2);
    
    NSLog(@"%@",ret==YES?@"YES":@"NO");
    
}

//- (void)work:(completeHandler)handler {
//    NSLog(@"%s",__FUNCTION__);
//    
//    BOOL ret = handler(3);
//    
//    NSLog(@"%@",ret==YES?@"YES":@"NO");
//}

- (void)work:(BOOL(^)(int))handler {
    NSLog(@"%s",__FUNCTION__);
    
    BOOL ret = handler(3);
    
    NSLog(@"%@",ret==YES?@"YES":@"NO");

}
@end
