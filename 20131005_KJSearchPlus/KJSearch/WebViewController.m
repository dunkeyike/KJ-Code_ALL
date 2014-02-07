//
//  WebViewController.m
//  KJSearch
//
//  Created by IKE on 13. 10. 2..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
// getter, setter 설정
@synthesize strDetailUrl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
	self.title = @"Web";
		// URL통신과 마찬가지로 통신용 Request객체를 선언 후 웹 주소로 설정
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:strDetailUrl]];
	// 웹뷰를 페이지 로딩 시작
	[wvDetail loadRequest:request];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebView Delegate 
/**
 *	@brief	페이지 로딩을 위한 준비
 *
 *	@param 	webView 	적용할 웹뷰
 *	@param 	request 	연결한 객체(주소)
 *	@param 	navigationType 	웹용 네비게이션 타입
 *
 *	@return	YES - 로딩 허용 // NO - 로딩 불허
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	return YES;
}

/**
 *	@brief	웹뷰가 로딩을 시작함
 *
 *	@param 	webView 	적용할 웹뷰
 */
- (void)webViewDidStartLoad:(UIWebView *)webView {
	// 인디게이터의 에니메이션을 시작시킴
	[aiWebLoading startAnimating];
	
}
/**
 *	@brief	웹뷰의 로딩이 끝남
 *
 *	@param 	webView 	적용할 웹뷰
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
	// 인디게이터의 에니메이션을 중지시킴 & 숨김
	[aiWebLoading setAlpha:0.0f];
	[aiWebLoading stopAnimating];
}
/**
 *	@brief	웹뷰 로딩중 에러 발생
 *
 *	@param 	webView 	적용할 웹뷰
 *	@param 	error 	에러객체
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	// 인디게이터의 에니메이션을 중지시킴 & 숨김
	[aiWebLoading setAlpha:0.0f];
	[aiWebLoading stopAnimating];

}


@end
