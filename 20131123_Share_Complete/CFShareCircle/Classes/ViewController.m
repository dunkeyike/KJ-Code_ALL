//
//  ViewController.m
//  CFShareCircle
//
//  Created by Camden on 12/18/12.
//  Copyright (c) 2012 Camden. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    shareCircleView = [[CFShareCircleView alloc] initWithFrame:self.view.frame];
    shareCircleView.delegate = self;
    [self.navigationController.view addSubview:shareCircleView];
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shareCircleCanceled:) name:@"shareCancel" object:nil];
    [super viewDidLoad];
}

- (void)shareCircleView:(CFShareCircleView *)aShareCircleView didSelectIndex:(int)index {
	switch (index) {
		case eShareModeEmail:
			[self sendMail];
			NSLog(@"이메일 보내기");
			break;
		case eShareModeFacebook:
			[self sendSocial:eShareModeFacebook];
			NSLog(@"페이스북 보내기");
			break;
		case eShareModeTwitter:
			[self sendSocial:eShareModeTwitter];
			NSLog(@"트위터 보내기");
			break;
		case eShareModeKakaoURL:
			[self kakaoUrlLink];
			NSLog(@"카카오톡 URL 링크 보내기");
			break;
		case eShareModeKakaoAPP:
			[self kakaoAppLink];
			NSLog(@"카카오톡 APP 링크 보내기");
			break;

		case eShareModeLine:
			[self sendLine];
			NSLog(@"라인 보내기");
			break;
		default:
			break;
	}
	
}

- (void)shareCircleCanceled: (NSNotification*)notification{ 
    NSLog(@"Share circle view was canceled.");
}


- (IBAction)shareButtonClicked:(id)sender {
    [shareCircleView animateIn];
}
#pragma mark - User Define Methods

/**
	이메일 보내기
	@returns void
 */
-(void) sendMail {

	if([MFMailComposeViewController canSendMail])
	{
		// 메일 전송 가능 상태
		mailComposeController = [[MFMailComposeViewController alloc] init];
		mailComposeController.mailComposeDelegate = self;


		[mailComposeController setToRecipients:[NSArray arrayWithObject:@"dunkeyike@gmail.com"]];
		[mailComposeController setCcRecipients:[NSArray arrayWithObject:@"ikedunkey@gmail.com"]];
		[mailComposeController setBccRecipients:[NSArray arrayWithObject:@"ikedunkey@gmail.com"]];
		[mailComposeController setSubject:@"이메일 공유 테스트"];

		NSString *bodyTemplate = @"<strong>내용 : <strong><br/>";
		[mailComposeController setMessageBody:bodyTemplate isHTML:YES];
		
		// 참고 싸이트 http://www.geocities.co.jp/Hollywood/9752/mime.html
		
		UIImage *image = [UIImage imageNamed:@"kakaotalk.png"];
		NSData *data = UIImagePNGRepresentation(image);
//		NSData *data = UIImageJPEGRepresentation(image, 1);
		
		[mailComposeController addAttachmentData:data
						   mimeType:@"image/jpeg"
						   fileName:@"attach_file_name.png"];
		
		[self presentViewController:mailComposeController animated:YES completion:nil];
	}else{
		// 메일 전송 불가능 상태
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"에러"
															message:@"메시지를 전송 할 수 없는 상황입니다. 메일계정이 설정되지 않았는지, 네트워크 연결이 되어있지 않는지 확인해주세요."
														   delegate:self cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
		[alertView show];
	}
	
}

/**
	SNS 공유하기
	@param mode SNS 모드 (facebook, twitter)
	@returns void
 */
- (void) sendSocial:(int)mode {

	NSString *serviceType;
	if (mode == eShareModeTwitter) {
		serviceType = SLServiceTypeTwitter;
	} else if(mode == eShareModeFacebook){
		serviceType = SLServiceTypeFacebook;
	}
	
	if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook] ||
		[SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
		SLComposeViewController *composeCtl = [SLComposeViewController composeViewControllerForServiceType:serviceType];
		
		[composeCtl setInitialText:@"SNS 공유 테스트\n"];
		[composeCtl addImage:[UIImage imageNamed:@"kakaotalk.png"]];
		[composeCtl addURL:[NSURL URLWithString:@"http://dunkey.kr"]];
		
		[composeCtl setCompletionHandler:^(SLComposeViewControllerResult result) {
			if (result == SLComposeViewControllerResultDone) {
				NSLog(@"SNS 공유 성공");
			}
			if (result == SLComposeViewControllerResultCancelled) {
				NSLog(@"SNS 공유 취소");
			}
		}];
		[self presentViewController:composeCtl animated:YES completion:nil];
	} else {
		// SNS 공유 불가
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"에러"
															message:@"SNS공유를 할수 없습니다. 설정에서 SNS계정을 설정 하였는지 확인해주세요."
														   delegate:self cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
		[alertView show];
	}
}

/**
	라인 메세지 보내기
	@returns void
 */
-(void) sendLine {

	// 참고 싸이트 http://media.line.naver.jp/howto/ja/
	
	NSString *plainString = @"라인으로 메세지 보내기 테스트";
    NSString *contentKey = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                        NULL,
                                                                                        (CFStringRef)plainString,
                                                                                        NULL,
                                                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                        kCFStringEncodingUTF8 );
    
    NSString *contentType = @"text";
    
    // LINE のサイトに遷移して、アプリが入っている場合はラインにリダイレクトする方法。
    NSString *urlString = [NSString
                           stringWithFormat: @"line://msg/%@/%@",
                           contentType, contentKey];
    NSURL *url = [NSURL URLWithString:urlString];

    /*
     // LINE に直接遷移。contentType で画像を指定する事もできる。アプリが入っていない場合は何も起きない。
	 ※iPhoneアプリから画像を送信する場合、
	 Pastboardに画像を添付し、
	 line://msg/image/(PastboardName)の形式でPastboardNameを設定して送信してください。
	 ※iOS7では画像送信をサポートしていません。
     */
    
	if([[UIApplication sharedApplication] canOpenURL:url]){
		[[UIApplication sharedApplication] openURL:url];
	} else {
		// 라인이 설치되어 있지 않으면 설치 하도록 알림창 표시
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"알림" message:@"라인이 설치되어 있지 않아 메세제를 전송하지 못하였습니다." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:@"설치하기", nil];
		alertView.tag = 100;
		[alertView show];
	}
}

#pragma mark - 카카오톡/카카오 스토리 설치 여부 판단
// 참고 싸이트 JP http://www.kakao.co.jp/link/
// 참고 싸이트 KR http://www.kakao.com/services/api/kakao_link

/**
	카카오톡 설치 여부 판단
	@returns BOOL	
			YES - 설치됨
			NO	- 설치안됨
 */
- (BOOL) isInstallKakaoTalk {

	if (![KakaoLinkCenter canOpenKakaoLink]) {
		// 카카오톡이 설치되어 있지 않으면 설치 하도록 알림창 표시
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"알림" message:@"카카오톡이 설치되어 있지 않아 메세제를 전송하지 못하였습니다." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:@"설치하기", nil];
		alertView.tag = 200;
		[alertView show];
		return NO;
    }
	return YES;
}

/**
	카카오스토리 설치 여부 판단
	@returns BOOL
			YES - 설치됨
			NO	- 설치안됨
 */

- (BOOL) isInstallKakaoStory {
	if (![KakaoLinkCenter canOpenStoryLink]) {
		// 카카오스토리가 설치되어 있지 않으면 설치 하도록 알림창 표시
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"알림" message:@"카카오스터리가 설치되어 있지 않아 메세제를 전송하지 못하였습니다." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:@"설치하기", nil];
		alertView.tag = 300;
		[alertView show];
		return NO;
    }
	return YES;
}
#pragma mark - 카카오톡 API


/**
	카카오톡으로 URL 메세지 보내기
	@returns void
 */
-(void) kakaoUrlLink {

    if ([self isInstallKakaoTalk]) {
		[KakaoLinkCenter openKakaoLinkWithURL:@"http://dunkey.kr"
								   appVersion:@"1.0"
								  appBundleID:@"com.trifort.meetApp"
									  appName:@"meeApp"
									  message:@"KJCode 카카오톡 URL Link 테스트"];
	}
}

/**
	카카오톡으로 APP Link 메세지 보내기
	@returns void
 */
-(void)kakaoAppLink {
    if ([self isInstallKakaoTalk]) {
		NSMutableArray *metaInfoArray = [NSMutableArray array];
		
		NSDictionary *metaInfoIOS = [NSDictionary dictionaryWithObjectsAndKeys:
									 @"ios", @"os",
									 @"phone", @"devicetype",
									 @"http://dunkey.kr", @"installurl",
									 @"kjcodeshare://", @"executeurl",
									 nil];
		
		[metaInfoArray addObject:metaInfoIOS];
		
		[KakaoLinkCenter openKakaoAppLinkWithMessage:@"KJCode 카카오톡 AppLink 테스트"
												 URL:@"http://link.kakao.com/?test-ios-app"
										 appBundleID:@"meeapp"
										  appVersion:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
											 appName:@"KJCodeShare"
									   metaInfoArray:metaInfoArray];
	}
}
#pragma mark - 카카오 스토리 API
- (void)sendTextOnlyStorylinkAction {
	if ([self isInstallKakaoStory]) {
		[KakaoLinkCenter openStoryLinkWithPost:@"text from StoryLink"
								   appBundleID:[[NSBundle mainBundle] bundleIdentifier]
									appVersion:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
									   appName:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]
									   urlInfo:nil];
	}
}

- (void) sendStorylinkHasCorrectUrlInfoAction {
	if ([self isInstallKakaoStory]) {
		NSArray *imageArray = [NSArray arrayWithObject:@"http://i4.ytimg.com/vi/gU2-ZMWm0xc/default.jpg"];
		NSDictionary *urlInfoDict = [NSDictionary dictionaryWithObjectsAndKeys:
									 @"CloudAthlas", @"title",
									 @"blahblahblah", @"desc",
									 imageArray, @"imageurl",
									 nil];
		
		[KakaoLinkCenter openStoryLinkWithPost:@"text from Storylink http://www.youtube.com/watch?v=gU2-ZMWm0xc&feature=g-vrec"
								   appBundleID:[[NSBundle mainBundle] bundleIdentifier]
									appVersion:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
									   appName:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]
									   urlInfo:urlInfoDict];
	}
}

- (void) sendStorylinkWithoutUrlInfoAction {
	if ([self isInstallKakaoStory]) {
		[KakaoLinkCenter openStoryLinkWithPost:@"text from Storylink http://www.youtube.com/watch?v=gU2-ZMWm0xc&feature=g-vrec"
								   appBundleID:[[NSBundle mainBundle] bundleIdentifier]
									appVersion:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
									   appName:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]
									   urlInfo:nil];
		
	}
}

- (void) sendStorylinkHasIncorrectUrlInfoAction {
	if ([self isInstallKakaoStory]) {
		NSArray *imageArray = [NSArray arrayWithObject:@"http://i4.ytimg.com/vi/gU2-ZMWm0xc/default.jpg"];
		NSDictionary *urlInfoDict = [NSDictionary dictionaryWithObjectsAndKeys:
									 @"blahblahblah", @"desc",
									 imageArray, @"imageurl",
									 nil];
		
		[KakaoLinkCenter openStoryLinkWithPost:@"text from Storylink http://www.youtube.com/watch?v=gU2-ZMWm0xc&feature=g-vrec story posting"
								   appBundleID:[[NSBundle mainBundle] bundleIdentifier]
									appVersion:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
									   appName:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]
									   urlInfo:urlInfoDict];
	}
}

#pragma mark - MFMailComposeViewControllerDelegate
/**
	메일 보내기 결과
	@param controller 메일컴포즈 컨트롤러
	@param result MFMailComposeResult
	@returns void
 */
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:
(NSError *)error {
	
	if (result == MFMailComposeResultCancelled) {
		NSLog(@"메일 전송 취소");
	}else if (result == MFMailComposeResultSaved) {
		NSLog(@"메일 임시 저장");
	}else if(result == MFMailComposeResultSent ){
		NSLog(@"메일 전송 성공");
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"알림" message:@"메일 전송이 완료 되었습니다." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
		[alertView show];
	}else if(result == MFMailComposeResultFailed){
		NSLog(@"메일 전송 실패");
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"알림" message:@"메일 전송에 실패 하였습니다." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
		[alertView show];
	}
	[controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIAlertView Delegate
/**
	경고창에서 선택된 버튼에 따른 처리
	@param alertView 경고창
	@param buttonIndex 누른 버튼 인덱스
	@returns void
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

	if (buttonIndex == 1) {
		// 라인 설치하러 가기
		if (alertView.tag == 100) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/jp/app/line/id443904275?mt=8"]];
		}
		// 카카오톡 설치하러 가기
		else if(alertView.tag == 200) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/jp/app/kakaotoku-wu-liao-tong-hua/id362057947?mt=8"]];
		}
		// 카카오 스토리 설치하러 가기
		else if(alertView.tag == 300){
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/jp/app/kakaosutori-kakaostory/id486244601?mt=8"]];
		}
	}
}
@end
