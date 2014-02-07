//
//  MemberModifyViewController.m
//  KJCodeMembers
//
//  Created by ZipsDev_Ike on 10/09/21.
//  Copyright 2010 Zips. All rights reserved.
//

#import "MemberModifyViewController.h"


@implementation MemberModifyViewController

@synthesize nameTextField;
@synthesize positionTextField;
@synthesize ageTextField;
@synthesize addressTextField;
@synthesize memberData;
@synthesize allMembersData;
@synthesize saveButton;
@synthesize indexPath;

@synthesize nextButton, prevButton;
@synthesize iconImageView;
@synthesize iconArray;
@synthesize iconIndex;
@synthesize iconName;

#pragma mark User Define Methods
// 텍스트필드 이외의 부븐을 클릭할때 불려지는 메소드
// 키보드를 감춘다.
-(IBAction)backgroungTap:(id)sender
{
	[self releaseKeyBoard];
}

#pragma mark -
#pragma mark Application Life

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// 저장 버튼 추가.
	[saveButton setTarget:self];
    [saveButton setAction:@selector(toggleSave)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton setTitle:@"저장"];
	
	// 텍스트필드 속성 설정
	nameTextField.autocorrectionType = UITextAutocorrectionTypeNo; // 자동완성 끄기
	nameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // 첫문자 대문자 변환 끄기(?)
	positionTextField.autocorrectionType = UITextAutocorrectionTypeNo;
	positionTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	ageTextField.autocorrectionType = UITextAutocorrectionTypeNo;
	ageTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	addressTextField.autocorrectionType = UITextAutocorrectionTypeNo;
	addressTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	nameTextField.tag = 1;	
	positionTextField.tag = 2;
	ageTextField.tag = 3;
	addressTextField.tag = 4;
	
	iconIndex = 0;

	iconArray = [[NSArray alloc] initWithObjects:@"face_01.png", @"face_02.png", @"face_03.png", @"face_04.png", @"face_05.png", @"face_06.png", @"face_07.png", @"face_08.png", @"face_09.png", @"face_10.png", nil];
	//NSArray *filterArray = [NSArray arrayWithObjects:@"a", @"b",nil];
	//NSArray *filterResultArray = [iconArray pathsMatchingExtensions:filterArray];
	//NSLog(@"filterResultArray : %@", filterResultArray);
	
	//NSLog(@"%@", iconArray);
	// 초기 문자열 설정 (데이터에서 읽어온 값 표시)
	nameTextField.text = [memberData valueForKey:@"NameOfMember"];
	positionTextField.text = [memberData valueForKey:@"KindOfMember"];
	ageTextField.text = [memberData valueForKey:@"AgeOfMember"];
	addressTextField.text = [memberData valueForKey:@"AddressOfMember"];
	NSString *imageStr = [[NSString alloc] initWithString:[memberData valueForKey:@"ImageOfMember"]]; 
	iconImageView.image = [UIImage imageNamed:imageStr];
	iconName.text = imageStr;
	iconIndex = [[memberData valueForKey:@"IconIndex"]intValue];
	
	NSLog(@"iconIndex : %d", iconIndex);
}

-(IBAction)toggleNext
{
	if (iconIndex > -1 || iconIndex < 10) {
		iconIndex++;
		if (iconIndex == 10) {
			iconIndex = 0;
		}
		NSString *imageStr = [[NSString alloc] initWithString:[iconArray objectAtIndex:iconIndex]]; 
		iconImageView.image = [UIImage imageNamed:imageStr];
		iconName.text = imageStr;
		NSLog(@"iconIndex : %d", iconIndex);
	}
}

-(IBAction)togglePrev
{
	if (iconIndex > -1 || iconIndex < 10) {
		iconIndex--;
		if (iconIndex == -1) {
			iconIndex = 9;
		}
		NSString *imageStr = [[NSString alloc] initWithString:[iconArray objectAtIndex:iconIndex]]; 
		iconImageView.image = [UIImage imageNamed:imageStr];
		iconName.text = imageStr;
		NSLog(@"iconIndex : %d", iconIndex);
	}
}

// TextField 키보드 릴리즈
-(void)releaseKeyBoard
{
	[nameTextField resignFirstResponder];
	[positionTextField resignFirstResponder];
	[ageTextField resignFirstResponder];
	[addressTextField resignFirstResponder];
}

// 저장 버튼을 눌렀을 때의 처리 메소드
-(void)toggleSave
{
	// 키보드를 숨긴후
	[self releaseKeyBoard];
	
	// 저장여부 확인 경고창 표시
	UIAlertView *alert = [[UIAlertView alloc] 
						  initWithTitle:@"저  장" 
						  message:@"데이터를 저장하겠습니까?"
						  delegate:self
						  cancelButtonTitle:@"취  소" 
						  otherButtonTitles:@"확  인",nil];

	[alert show];
	[alert release];
}

// 데이터 저장
-(void) saveData
{
	// 저장할 데이터를 격납할 딕셔너리 생성
	
	NSLog(@"iconIndex : %d", iconIndex);
	NSLog(@"iconIndex : %@", [iconArray objectAtIndex:iconIndex]);
	
	// 숫자데이터를 문자열로 바꾸기 위해 NSNumber 객체 사용
	NSNumber *tempNum = [NSNumber numberWithInt:iconIndex];
	NSString *indexStr = [tempNum stringValue];
	
	NSDictionary *tempDic = 
	[NSDictionary dictionaryWithObjectsAndKeys:
	 nameTextField.text, @"NameOfMember",
	 positionTextField.text, @"KindOfMember",
	 [iconArray objectAtIndex:iconIndex], @"ImageOfMember",
	 indexStr, @"IconIndex",
	 ageTextField.text, @"AgeOfMember",
	 addressTextField.text, @"AddressOfMember", nil];
	
	NSLog(@"%@",tempDic);
	
	// 선택한 오브젝트를 지운후 새로운 데이터를 삽입한다.
	[[allMembersData objectAtIndex:indexPath.section]removeObjectAtIndex:indexPath.row];
	[[allMembersData objectAtIndex:indexPath.section]insertObject:tempDic atIndex:indexPath.row];
		
	// 파일에 저장
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *myPath =[documentsDirectory stringByAppendingPathComponent:@"member.plist"];
	[allMembersData writeToFile:myPath atomically:YES];
}

#pragma mark -
#pragma mark AlertView Delegates

// 경고창에서 확인을 눌렀을때만 저장
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex) {
		// 취소버튼을 누르면 상세뷰로 넘어감
		case 0:
			NSLog(@"Clicked Cancel Button");
			[self.navigationController popViewControllerAnimated:YES];
			break;
		// 저장 버튼을 누르면 저장후 리스트뷰로 넘어감
		case 1:
			NSLog(@"Clicked OK Button");
			[self saveData];
			[self.navigationController popToRootViewControllerAnimated:YES];
			break;
		default:
			break;
	}
}

#pragma mark -
#pragma mark TextField Delegates

// 리턴키를 누르면 다음 항목으로 넘어 감..
// 나이를 입력하는 텍스트 필드는 리턴키가 없으므로 수동으로 옮겨야함.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	NSLog(@"%s", __FUNCTION__);
	if (textField.tag == 1) {
		[positionTextField becomeFirstResponder];
	}
	else if(textField.tag == 2)
	{
		[ageTextField becomeFirstResponder];
	}
	else if(textField.tag == 3)
	{
		[addressTextField becomeFirstResponder];
	}
	else {
		[self releaseKeyBoard];
	}
	return YES;
}

#pragma mark -
#pragma mark Memory Management
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.nameTextField = nil;
	self.positionTextField = nil;
	self.ageTextField = nil;
	self.addressTextField = nil;
	self.memberData = nil;
	self.allMembersData = nil;
	self.indexPath = nil;
	self.saveButton = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[nameTextField release];
	[positionTextField release];
	[ageTextField release];
	[addressTextField release];
	[memberData release];
	[allMembersData release];
	[saveButton release];
	[indexPath release];
	[prevButton release];
	[nextButton	release];
	[iconImageView release];
	[iconArray release];
	[iconName release];
    [super dealloc];
}

@end
