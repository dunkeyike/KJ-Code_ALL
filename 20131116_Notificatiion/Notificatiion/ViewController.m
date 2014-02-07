//
//  ViewController.m
//  Notificatiion
//
//  Created by Dunkey on 2013. 11. 15..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter addObserver:self selector:@selector(one) name:@"toggleOne" object:nil];
	[notificationCenter addObserver:self selector:@selector(two) name:@"toggleTwo" object:nil];
	[notificationCenter addObserver:self selector:@selector(three) name:@"toggleThree" object:nil];
	[notificationCenter addObserver:self selector:@selector(changeColor:) name:@"changeNaviColor" object:nil];
	

	// 키보드가 표시될때
	[notificationCenter addObserver:self selector:@selector(keyboardWillShow:)
						 name: UIKeyboardWillShowNotification object:nil];
	// 키보드가 사라질때
	[notificationCenter addObserver:self selector:@selector(keyboardWillHide:)
						 name: UIKeyboardWillHideNotification object:nil];
	
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
	[self.view addGestureRecognizer:singleTap];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) one {
	lblText.text = @"ONE";
}
-(void) two {
	lblText.text = @"TWO";
}

-(void) three {
	lblText.text = @"THREE";
}
-(void) changeColor:(NSNotification *)notification {
	
	NSDictionary *tempDic = [notification object];
	UIColor *naviColor = [tempDic objectForKey:@"NaviBarColor"];
	UIColor *tintColor = [tempDic objectForKey:@"TintColor"];
	
    [self.navigationController.navigationBar setBarTintColor:naviColor];
	lblText.textColor = tintColor;
}
-(void)keyboardWillShow:(NSNotification *)notification {
	NSLog(@"notification : %@", notification);
	tfInput.placeholder = @"쓰고싶은말을 쓰세요";

}
-(void) keyboardWillHide:(NSNotification *)notification {
	tfInput.placeholder = @"";
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
	[tfInput resignFirstResponder];		// 텍스트필드에서 포커스를 뺌
//	[tfInput becomeFirstResponder];		// 텍스트필드에 포커스를 맞춤
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	NSLog(@"%s", __FUNCTION__);
	return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
	NSLog(@"%s", __FUNCTION__);
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	NSLog(@"%s", __FUNCTION__);
	return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
	NSLog(@"%s", __FUNCTION__);
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	NSLog(@"%s", __FUNCTION__);
	return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
	NSLog(@"%s", __FUNCTION__);
	return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	NSLog(@"%s", __FUNCTION__);
	[textField resignFirstResponder];
	return YES;
}
@end
