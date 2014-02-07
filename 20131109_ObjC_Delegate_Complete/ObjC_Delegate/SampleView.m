//
//  SampleView.m
//  ObjC_Delegate
//
//  Created by Dunkey on 2013. 10. 30..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "SampleView.h"

@implementation SampleView
@synthesize delegate;
@synthesize ivProfile;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // 테두리 둥글게
    self.layer.cornerRadius = 10;
}


-(void)changeLabel:(CGFloat)alpha isLike:(BOOL)isLike {
    // super view에서 호출하는 메소드
    if (isLike) {
        ivHate.alpha = 0.0f;
        ivLike.alpha = alpha;
    } else {
        ivLike.alpha = 0.0f;
        ivHate.alpha = alpha;
    }
}


/**
	좋아요 버튼을 눌렀을때의 처리
	@param sender 눌러진 객체
 */
-(IBAction)onLike:(id)sender {
    btnLike.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [UIView animateWithDuration:0.2 animations:^{
        [btnLike.layer setAffineTransform:CGAffineTransformMakeScale(1.5, 1.5)];
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            [btnLike.layer setAffineTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        }completion:^(BOOL finished) {
            [self.delegate onLikeBtn];
        }];
    }];
    
}
/**
    싫어요 버튼을 눌렀을때의 처리
    @param sender 눌러진 객체
*/
-(IBAction)onHate:(id)sender {
    btnHate.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [UIView animateWithDuration:0.2 animations:^{
        [btnHate.layer setAffineTransform:CGAffineTransformMakeScale(1.5, 1.5)];
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            [btnHate.layer setAffineTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        }completion:^(BOOL finished) {
            [self.delegate onHateBtn];
        }];
    }];
}

@end
