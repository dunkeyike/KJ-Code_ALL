//
//  ViewController.h
//  TableViewTest_0901
//
//  Created by IKE on 13. 9. 1..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	// 화면에 보여지는 테이블뷰
	IBOutlet UITableView	*tvTempTableView;
	// 0번째 섹션 셀에 보여질 테이터 (문자열)
	NSString				*dataForSection0;
	// 2번째 섹션 셀에 보여질 테이터 (문자열)
	NSString				*dataForSection2;
	// 1번째 섹션 셀에 보여질 테이터 (가변배열)
	NSMutableArray			*demoData;
	// 1번째 섹션에서 선택된 셀의 인덱스를 보관하는 변수
	int						selectedIndex;
	// 드롭다운으로 셀이 열려있는지 닫혀있는지 판별하는 플래그
	BOOL					isShowList;
}
@end
