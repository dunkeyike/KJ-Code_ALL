//
//  ResultViewController.h
//  KJSearch
//
//  Created by IKE on 13. 10. 2..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"

@interface ResultViewController : UITableViewController {
	// 검색화면에서 받아온 검색결과를 보관할 배열 객체
	NSMutableArray *arrResult;
}
// 외부에서 사용할수 있게 프로퍼티를 설정
@property (nonatomic, strong) NSMutableArray *arrResult;
@end
