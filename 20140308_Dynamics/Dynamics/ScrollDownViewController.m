//
//  ScrollDownViewController.m
//  Dynamics
//
//  Created by Dunkey on 2014. 2. 26..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "ScrollDownViewController.h"

@interface ScrollDownViewController () {
	BOOL		isScrollDown;
	CGPoint		startPoint;
}
@property (nonatomic, weak) IBOutlet UIView		*vScrollView;
@property (nonatomic, weak) IBOutlet UIButton	*btnScrollUpDown;
@property (nonatomic, strong) UIDynamicAnimator	*animator;
@property (nonatomic, strong) UIDynamicItemBehavior	*dropItem;
@end

@implementation ScrollDownViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	isScrollDown = NO;
 
	_animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panTopView:)];
    [_vScrollView addGestureRecognizer:panGesture];
}

- (IBAction)onScrollUpDown:(id)sender {
	// 뷰를 올려준다.
	// 뷰에니메이션 이용
	
	if (isScrollDown) {
		
		[_animator removeAllBehaviors];
		
		UIGravityBehavior *gra = [[UIGravityBehavior alloc] initWithItems:@[_vScrollView]];
		// 중력의 힘을설정
		gra.gravityDirection = CGVectorMake(0, -5);
		
		UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[_vScrollView]];
		[collision addBoundaryWithIdentifier:@"border2" fromPoint:CGPointMake(0, -450) toPoint:CGPointMake(320, -450)];
		
		[_animator addBehavior:gra];
		[_animator addBehavior:_dropItem];
		[_animator addBehavior:collision];
		
		[_animator updateItemUsingCurrentState:_vScrollView];
		
			isScrollDown = NO;
//		[UIView animateWithDuration:0.75 animations:^{
//			_vScrollView.frame = CGRectMake(0, -450, 320, 568);
//		} completion:^(BOOL finished) {
//			isScrollDown = NO;
//		}];
	}
	// 뷰를 내려준다
	// 다이나믹을 이용
	else {
		isScrollDown = YES;
		[_animator removeAllBehaviors];
		_dropItem = [[UIDynamicItemBehavior alloc] initWithItems:@[_vScrollView]];
		// 뷰이 반동력(탈력성)을 설정한다
		_dropItem.elasticity = 0.3;
		
		UIGravityBehavior *gra = [[UIGravityBehavior alloc] initWithItems:@[_vScrollView]];
		// 중력의 힘을설정
		gra.magnitude = 3.0;
		UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[_vScrollView]];
		[collision addBoundaryWithIdentifier:@"border" fromPoint:CGPointMake(0, 569) toPoint:CGPointMake(320, 569)];
		[_animator addBehavior:gra];
		[_animator addBehavior:_dropItem];
		[_animator addBehavior:collision];
		
		[_animator updateItemUsingCurrentState:_vScrollView];
	}
}

- (void) panTopView:(UIPanGestureRecognizer*)gesture {

	// 처음 터치한 곳의 좌표를 저장해 둔다
	if (gesture.state == UIGestureRecognizerStateBegan) {
		startPoint = [gesture locationInView:self.view];
	}
	// 터치 좌표가 변하면 뷰를 옮겨준다
	if (gesture.state == UIGestureRecognizerStateChanged)
    {
		CGPoint translation = [gesture translationInView:self.view];
		gesture.view.center = CGPointMake(gesture.view.center.x,
											 gesture.view.center.y + translation.y);
		[gesture setTranslation:CGPointMake(0, 0) inView:self.view];
    }
	// 터치가 끝나면 욺직인 거리를 판단해서 뷰를 올리던지 내리던지 한다
    if(gesture.state == UIGestureRecognizerStateEnded){
		CGPoint p = [gesture locationInView:self.view];
		
		if (p.y - startPoint.y > 60) {
			isScrollDown = NO;
			[self onScrollUpDown:nil];
			return;
		} else {
			isScrollDown = YES;
			[self onScrollUpDown:nil];
			return;
		}
		
		if (p.y - startPoint.y < -60) {
			isScrollDown = YES;
			[self onScrollUpDown:nil];
			return;
		} else {
			isScrollDown = NO;
			[self onScrollUpDown:nil];
			return;
		}
    }
}
@end
