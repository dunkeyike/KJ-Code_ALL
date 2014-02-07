//
//  Human.h
//  BlockSampleApplication
//
//  Created by Lee jaeeun on 2013/11/09.
//  Copyright (c) 2013年 kjcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HumanDelegate;

typedef BOOL(^completeHandler)(int);

@interface Human : NSObject {
    
    id _tar;
    SEL _sel;
}

@property(nonatomic) id<HumanDelegate> delegate;

//셀렉터를 이용한 콜백함수 처리.
- (id)initWithTarget:(id)target action:(SEL)action;

- (void)eat:(NSString *)rice;
- (void)sleep;
- (void)work;

//딜리게이트 메소드
- (void)doEat;

//block을 이용한 콜백처리
- (void)eat:(NSString *)rice complete:(void(^)(void))handler;
- (void)sleep:(BOOL(^)(int,int))handler;
//- (void)work:(completeHandler)handler;
- (void)work:(BOOL(^)(int))handler;

@end


//딜리게이트를 이용한 콜백처리.
@protocol HumanDelegate <NSObject>

@optional
- (void)human:(Human *)obj compelte:(BOOL)on;

@end