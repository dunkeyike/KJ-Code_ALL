//
//  RootViewController.h
//  KJCodeMembers
//
//  Created by ZipsDev_Ike on 10/08/30.
//  Copyright Zips 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEVELOPER_SECTION 0		// 개발자 섹션 번호 정의문
#define DESIGNER_SECTION 1		// 디자이너 섹션 번호 정의문

@interface RootViewController : UITableViewController {
	NSMutableArray *members;		// 파일에서 데이터를 불러와서 저장할 수정가능한 배열 객체
	BOOL isEdited;					// 삭제/추가/이동등 편집이 이루어 졌는지 판단하기위한 변수 
}
@property (nonatomic, retain) NSMutableArray *members;
@property (assign) BOOL isEdited;

@end
