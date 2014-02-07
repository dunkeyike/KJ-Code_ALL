//
//  MemberDetailViewController.m
//  KJCodeMembers
//
//  Created by ZipsDev_Ike on 10/09/17.
//  Copyright 2010 Zips. All rights reserved.
//

#import "MemberDetailViewController.h"
#import "MemberModifyViewController.h"

@implementation MemberDetailViewController
@synthesize memberData;
@synthesize allMembersData;
@synthesize memberImage;
@synthesize nameLabel, kindLabel, ageLabel, addressLabel;
@synthesize modifyButton;
@synthesize indexPath;


// 화면의 초기 설정
// 리스트뷰에서 선택된 데이터를 화면에 표시함
- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.title = @"상세정보";
	// 편집 버튼추가	
	[modifyButton setTarget:self];
    [modifyButton setAction:@selector(toggleModify)];
	[modifyButton setTitle:@"수정"];
	self.navigationItem.rightBarButtonItem = modifyButton;
	
	// 이미지, 이름, 직책, 나이, 주소 표시
	memberImage.image = [UIImage imageNamed:[memberData valueForKey:@"ImageOfMember"]];
	nameLabel.text = [memberData valueForKey:@"NameOfMember"];
	kindLabel.text = [memberData valueForKey:@"KindOfMember"];
	ageLabel.text = [memberData valueForKey:@"AgeOfMember"];
	addressLabel.text = [memberData valueForKey:@"AddressOfMember"];
}

// 편집 버튼을 눌렀을때 처리하는 메소드
-(void)toggleModify
{
	// 편집뷰를 초기화한후
	MemberModifyViewController *modifyView = [[MemberModifyViewController alloc] initWithNibName:@"MemberModifyViewController" bundle:nil];
	// 편집뷰에서 내용 수정후 저장하기위해 모든 데이터를 넘겨줌
	modifyView.allMembersData = [self.allMembersData copy];
	// 현재 선택된 데이터만 넘겨줌
	modifyView.memberData = self.memberData;
	// 현재 선택된 데이타의 경로 indexPath를 넘겨줌(오래된 데이터 삭제및 새로운 데이터 추가를 위해 필요)
	modifyView.indexPath = self.indexPath;						
	// 다음 페이지를 보여줌
	[self.navigationController pushViewController:modifyView animated:YES];
	[modifyView release];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [memberData release];
	[allMembersData release];
	[memberImage release];
	[nameLabel release];
	[kindLabel release];
	[ageLabel release];
	[addressLabel release];
	[modifyButton release];
	[indexPath release];
	[super dealloc];	
}


@end
