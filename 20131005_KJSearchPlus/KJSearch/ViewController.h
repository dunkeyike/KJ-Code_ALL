//
//  ViewController.h
//  KJSearch
//
//  Created by IKE on 13. 10. 2..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ResultViewController.h"

@interface ViewController : UIViewController <NSURLConnectionDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {

	IBOutlet UITextField				*tfSearchInput;			/**< 검색어를 입력받을 UITextField */
	IBOutlet UIActivityIndicatorView	*aiLodaingIndicator;	/**< 로딩중임을 알려주는 인디게이터 */
	NSString							*strSearch;				/**< 검색어를 보존할 NSString객체 */
	NSMutableData						*responseData;			/**< JSON 데이터를 보존할 NSMutableData객체 */
	NSURLConnection						*conn;					/**< URL통신을 위한 객체 */
	
	IBOutlet UITableView				*tvSearchWords;
	NSMutableArray						*arrHistory;
}

/**< 검색 버튼을 눌렀을때의 이벤트 메소드 */
- (IBAction)onSearchBtn:(UIButton *)sender;

@end