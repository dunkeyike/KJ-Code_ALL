//
//  ViewController.m
//  ObjC_Delegate
//
//  Created by Dunkey on 2013. 10. 30..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "ViewController.h"

#define ORIGIN_RECT     CGRectMake(48,172,225,225)
#define MOVE_TO_LIKE    YES
#define MOVE_TO_HATE    NO

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    likeCount = 0;
    hateCount = 0;
    sampleView.delegate = self;
    selectedImageIndex = 0;
    sampleView.ivProfile.image = [UIImage imageNamed:[arrImages objectAtIndex:selectedImageIndex]];
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panItem:)];
    [sampleView addGestureRecognizer:panGesture];
    arrImages = [[NSArray alloc] initWithObjects:
                           @"http://www.free5.kr/files/attach/images/120/298/831d3ded9e52e513f5623e1a14ea5c5b.jpg",
                           @"http://www.free5.kr/files/attach/images/120/306/2d43717fa0a1698a50e237373218d978.jpg",
                           @"http://www.free5.kr/files/attach/images/120/304/f64ba96963c56a478ae605d8f190f351.JPG",
                           @"http://www.free5.kr/files/attach/images/120/302/8c800b08215b173a967b15d903939211.jpg",
                           @"http://www.free5.kr/files/attach/images/120/300/9371a64b491a9039e2db1b92616579ff.jpg",
                           @"http://www.free5.kr/files/attach/images/120/296/91535017139782105d673fd857a27e13.jpg",
                           @"http://www.free5.kr/files/attach/images/120/294/b06cf8ec120a470522d01863d4d9be93.jpg",
                           @"http://www.free5.kr/files/attach/images/120/292/db48f05fc4934334f60e441aaa21b927.jpg",
                           @"http://www.free5.kr/files/attach/images/120/290/940eda457947f8497e99cf81c4cd150d.jpg",
                           @"http://www.free5.kr/files/attach/images/120/286/2016fced1e25430f5ae02c966e00c442.jpg",
                           nil];
    [self downloadingServerImageFromUrl:sampleView.ivProfile AndUrl:[arrImages objectAtIndex:0]];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - user define method
- (void) panItem:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:self.view];
    NSLog(@"point : %@",NSStringFromCGPoint(point));
    sampleView.center = point;

    // 스와이프 동작이 시작해서 움직이는 경우
    if ((pan.state == UIGestureRecognizerStateBegan
		 || pan.state == UIGestureRecognizerStateChanged)
        && [pan numberOfTouches] > 0) {
        
        CGPoint translation = [pan translationInView:self.view];
        NSLog(@"translation : %@",NSStringFromCGPoint(translation));
		if (translation.x > 20) {
            [sampleView changeLabel:(fabsf(translation.x) / 80) isLike:MOVE_TO_LIKE];
            isLike = YES;
		}
        if(translation.x < -20){
            [sampleView changeLabel:(fabsf(translation.x) / 80) isLike:MOVE_TO_HATE];
            isLike = NO;
		}
    // 스와이프 동작이 끝났을경우
    } else if (pan.state == UIGestureRecognizerStateEnded) {

        [self swipeItem:isLike];
        [self performSelector:@selector(moveToOriginalPosition) withObject:Nil afterDelay:1.0];
        
    }
}

/**
	이미지를 원래 위치로 돌려놈
*/
-(void) moveToOriginalPosition {

    [self changeImage];
    [sampleView changeLabel:0 isLike:NO];
    sampleView.alpha = 0.0f;
    [UIView animateWithDuration:0.3 animations:^{
        sampleView.frame = ORIGIN_RECT;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            sampleView.alpha = 1.0f;
        }];
        
    }];
}
/**
	이미지를 변경함
*/
-(void) changeImage {
    sampleView.ivProfile.image = nil;
    if (selectedImageIndex < [arrImages count]) {
        [self downloadingServerImageFromUrl:sampleView.ivProfile AndUrl:[arrImages objectAtIndex:selectedImageIndex]];
    } else {
        selectedImageIndex = 0;
        [self downloadingServerImageFromUrl:sampleView.ivProfile AndUrl:[arrImages objectAtIndex:selectedImageIndex]];
    }
    
}

/**
	중앙의 이미지를 이동시킴
	@param moveDir 이동시킬 방향 YES -> Like 방향 // NO -> Hate 방향
*/
-(void) swipeItem :(BOOL)moveDir {

    selectedImageIndex++;
    [UIView animateWithDuration:0.25 animations:^{
        if (!moveDir) {
            hateCount++;
            lblHateCount.text = [NSString stringWithFormat:@"%d", hateCount];
            sampleView.frame = CGRectMake(-300, sampleView.frame.origin.y, sampleView.frame.size.width, sampleView.frame.size.height);
        } else {
            likeCount++;
            lblLikeCount.text = [NSString stringWithFormat:@"%d", likeCount];
            sampleView.frame = CGRectMake(350, sampleView.frame.origin.y, sampleView.frame.size.width, sampleView.frame.size.height);
        }
    }];
}
#pragma mark - UIGestureRecognizer Delegate
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

    // 스와이프가 가로방향에만 작용하도록 설정
	if (gestureRecognizer == panGesture) {
        if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            UIPanGestureRecognizer *panRecognizer = (UIPanGestureRecognizer *)gestureRecognizer;
            CGPoint velocity = [panRecognizer velocityInView:self.view];
            return ABS(velocity.x) > ABS(velocity.y);
        }
	}
    return NO;
}

#pragma mark - sampleView Delegate
-(void)onLikeBtn {
    [self swipeItem:MOVE_TO_LIKE];
    [self performSelector:@selector(moveToOriginalPosition) withObject:nil afterDelay:1];
}
-(void)onHateBtn {
    [self swipeItem:MOVE_TO_HATE];
    [self performSelector:@selector(moveToOriginalPosition) withObject:nil afterDelay:1];
}

/**
    URL로부터 이미지 가져오기
    처음 웹에서 읽어온 이미지는 캐쉬에 저장한다.
    캐쉬에 없는 경우 웹에서 이미지를 불러 들인다.
 
    @param imgView 웹에서 가져온 이미지를 적용할 객체
    @param strUrl 이미지URL Path
    @returns void
 */
- (void)downloadingServerImageFromUrl:(UIImageView*)imgView AndUrl:(NSString*)strUrl {
	
	NSString* theFileName = [NSString stringWithFormat:@"%@.png",[[strUrl lastPathComponent] stringByDeletingPathExtension]];
	
	
	NSFileManager *fileManager =[NSFileManager defaultManager];
	NSString *fileName = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"tmp/%@",theFileName]];
	
	
	
	imgView.backgroundColor = [UIColor clearColor];
	UIActivityIndicatorView *actView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	[imgView addSubview:actView];
	[actView startAnimating];
	CGSize boundsSize = imgView.bounds.size;
	CGRect frameToCenter = actView.frame;
	// center horizontally
	if (frameToCenter.size.width < boundsSize.width)
		frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
	else
		frameToCenter.origin.x = 0;
	
	// center vertically
	if (frameToCenter.size.height < boundsSize.height)
		frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
	else
		frameToCenter.origin.y = 0;
	
	actView.frame = CGRectMake((imgView.frame.size.width - actView.frame.size.width) / 2,
                               (imgView.frame.size.height - actView.frame.size.height) / 2,
                               actView.frame.size.width, actView.frame.size.height);
	
	
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_async(queue, ^{
		
		NSData *dataFromFile = nil;
		NSData *dataFromUrl = nil;
		
		dataFromFile = [fileManager contentsAtPath:fileName];
		if(dataFromFile==nil){
			dataFromUrl=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:strUrl]];
		}
		
		dispatch_sync(dispatch_get_main_queue(), ^{
			
			if(dataFromFile!=nil){
				imgView.image = [UIImage imageWithData:dataFromFile];
			}else if(dataFromUrl!=nil){
				imgView.image = [UIImage imageWithData:dataFromUrl];
				NSString *fileName = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"tmp/%@",theFileName]];
				
				BOOL filecreationSuccess = [fileManager createFileAtPath:fileName contents:dataFromUrl attributes:nil];
				if(filecreationSuccess == NO){
					NSLog(@"Failed to create the html file");
				}
				
			}else{
				imgView.image = [UIImage imageNamed:@"temp_img"];
			}
			[actView removeFromSuperview];
			[imgView setBackgroundColor:[UIColor clearColor]];
		});
	});
}

@end
