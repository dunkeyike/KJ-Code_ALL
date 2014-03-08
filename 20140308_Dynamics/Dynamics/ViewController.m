//
//  ViewController.m
//  Dynamics
//
//  Created by Dunkey on 2014. 2. 25..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface ViewController ()
// 다이나믹 효과를 받을 빨간 뷰
@property (nonatomic, weak) IBOutlet UIView *dropView;
// 모션이펙트 효과를 받을 배경이미지
@property (nonatomic, weak) IBOutlet UIImageView *ivBackground;
// 다이나믹 효과의 기본 객체
@property (nonatomic, strong) UIDynamicAnimator *animtor;
// 스냅효과를 내기위한 객체
@property (nonatomic, strong) UISnapBehavior *snapBehavior;
// UIDynamicAnimator에 적용할 중력객체
@property (nonatomic, strong) UIGravityBehavior *gravity;
// 실제로 다이나믹 효과를 받을 객체
@property (nonatomic, strong) UIDynamicItemBehavior *dropItem;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	_ivBackground.center = self.view.center;
	_dropItem = [[UIDynamicItemBehavior alloc] initWithItems:@[_dropView]];
    // 객체의 탄성 설정
	_dropItem.elasticity = 0.5;
	// 다이나믹 효과를 받을 뷰 설정
	_animtor = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    // 중력을 받을 아이템 설정
	_gravity = [[UIGravityBehavior alloc] initWithItems:@[_dropView]];
		
    // 객체간의 충돌판정을 위한 객체 설정
	UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[_dropView]];
    // 화면의 테두리에도 충돌판정을 할지 설정
	collision.translatesReferenceBoundsIntoBoundary	= YES;
	
    // 다이나믹효과 객체에 각각의 아이템을 설정
	[_animtor addBehavior:_gravity];
	[_animtor addBehavior:_dropItem];
	[_animtor addBehavior:collision];
	
    
    // 스냅 효과를 내기위한 탭 제스쳐 설정
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
	tap.numberOfTapsRequired = 1;
	[self.view addGestureRecognizer:tap];
	
    // 스냅효과에서 다시 중력에 의해 떨어지는 효과를 위한 더블탭
	UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapView:)];
	doubleTap.numberOfTapsRequired = 2;
	[self.view addGestureRecognizer:doubleTap];
    
    // 모션 이펙트 설정
    // 화면의 x축이동에 대한 모션 설정
	UIInterpolatingMotionEffect *interpolatingHorizontal = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    interpolatingHorizontal.minimumRelativeValue = @-80.0;
    interpolatingHorizontal.maximumRelativeValue = @80.0;
	
    // 화면의 y축이동에 대한 모션 설정
    UIInterpolatingMotionEffect *interpolatingVertical = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    interpolatingVertical.minimumRelativeValue = @-80.0;
    interpolatingVertical.maximumRelativeValue = @80.0;
    // 두 모션를 모아 이펙트그룹으로 설정후 배경이미지에 적용
	UIMotionEffectGroup *effectGroup = [UIMotionEffectGroup new];
	effectGroup.motionEffects = @[interpolatingHorizontal, interpolatingVertical],
    [_ivBackground addMotionEffect:effectGroup];


}
- (void) tapView:(UITapGestureRecognizer*)gesture {
	CGPoint point = [gesture locationInView:self.view];
    // 기존의 스냅을 삭제한후 (중복으로 추가되어버리는것 방지)
	[_animtor removeBehavior:_snapBehavior];
    // 새로운 스냅객체를 생성후 탭한 위치로 객체를 이동시킴
	UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:_dropView snapToPoint:point];
    // 제동력? 감쇠력? 설정
    snap.damping = 0.5;
	[_animtor addBehavior:snap];
	_snapBehavior = snap;
}
- (void) doubleTapView:(UITapGestureRecognizer*)gesture {
    // 더블탭을 하면 스냅객체를 삭제후 중력만 다시 받게 한다.
	[_animtor removeBehavior:_snapBehavior];
	[_animtor updateItemUsingCurrentState:_dropView];

}

@end
