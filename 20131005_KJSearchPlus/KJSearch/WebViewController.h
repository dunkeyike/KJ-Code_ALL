//
//  WebViewController.h
//  KJSearch
//
//  Created by IKE on 13. 10. 2..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>{
	IBOutlet UIWebView					*wvDetail;			/**< 웹페이지를 보여주기 위한 UIWebView 객체 */
	NSString							*strDetailUrl;		/**< 웹페이지 주소를 보존할 문자열 객체 */
	IBOutlet UIActivityIndicatorView	*aiWebLoading;		/**< 웹페이지 로딩용 인디게이터 */
}
// 외부에서 접근 할수있도록 프로퍼티 선언
@property (nonatomic, strong) NSString *strDetailUrl;
@end
