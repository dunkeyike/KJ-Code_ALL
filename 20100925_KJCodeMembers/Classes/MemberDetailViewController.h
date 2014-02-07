//
//  MemberDetailViewController.h
//  KJCodeMembers
//
//  Created by ZipsDev_Ike on 10/09/17.
//  Copyright 2010 Zips. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MemberDetailViewController : UIViewController {
	NSDictionary *memberData;		// 리스트뷰에서 선택된 데이타를 저장하기위한 객체. 현제 뷰에서 데이터를 뿌려줌
	NSArray *allMembersData;		// 리스트뷰의 모든 객체. 현제 뷰에서는 아무것도 안하고 편집뷰로 넘어 갈때 넘겨줌
	NSIndexPath *indexPath;			// 리스트뷰에서 선택된 indexPath를 저장하기위한 객체. 현제 뷰에서는 아무것도 안하고 편집뷰로 넘어 갈때 넘겨줌
	UIImageView *memberImage;		// 이미지 표시
	UILabel *nameLabel;				// 이름 표시
	UILabel *kindLabel;				// 직책 표시
	UILabel *ageLabel;				// 나이 표시
	UILabel *addressLabel;			// 주소 표시
	UIBarButtonItem *modifyButton;	// 편집버튼
}

@property (retain) NSDictionary *memberData;
@property (retain) NSArray *allMembersData;
@property (nonatomic, retain) IBOutlet UIImageView *memberImage;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *kindLabel;
@property (nonatomic, retain) IBOutlet UILabel *ageLabel;
@property (nonatomic, retain) IBOutlet UILabel *addressLabel;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *modifyButton;
@property (nonatomic, retain) NSIndexPath *indexPath;

@end
