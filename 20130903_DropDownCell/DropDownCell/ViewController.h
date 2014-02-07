//
//  ViewController.h
//  DropDownCell
//
//  Created by IKE on 13. 9. 3..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	IBOutlet UITableView *tvList;
	
	NSArray				*arrArray;		// 인덱스를 가지는 오브젝트 배열
	NSMutableArray		*arrList;

	NSDictionary		*dicObjects;	// 키와 값을 가지는 배열
	NSMutableDictionary *mDicObjects;
	
	
	int				intSelectIndex;
	BOOL			isCellOpen;
}
@end
