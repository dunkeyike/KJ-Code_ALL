//
//  ResultViewController.m
//  KJSearch
//
//  Created by IKE on 13. 10. 2..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController
// getter, setter 설정
@synthesize arrResult;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
	self.title = @"Reslut";
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

/**
 *	@brief	테이블셀의 객수 설정
 *
 *	@param 	tableView 	적용한 테이블
 *	@param 	section 	적용할 섹션
 *
 *	@return	셀 갯수
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// 검색결과갯수에 하나를 더 한 만큼 셀을 구현한다.
	// 제일 밑에 more셀을 위해 +1 을 하였음
    return [arrResult count] + 1;
}

/**
 *	@brief	각셀의 높이를 설정
 *
 *	@param 	tableView 	적용할 테이블
 *	@param 	indexPath 	셀의 위치정보(섹션,로우)
 *
 *	@return	셀의 높이
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// 제일 마지막 셀만 높이를 달리함
	if (indexPath.row < [arrResult count]) {
		return 137;
	} else {
		return 44;
	}
}
/**
 *	@brief	셀을 구성함
 *
 *	@param 	tableView 	적용할 테이블
 *	@param 	indexPath 	셀의 위치정보
 *
 *	@return	구성된 셀
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 리턴할 셀을 선언
    UITableViewCell *cell;
	
	// 젤 마지막 셀만 다르게 구성
	if (indexPath.row < [arrResult count]) {
		// 스토리보드 에서 설정한 셀의 ID로 제사용셀을 만든다.
		cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
		
		// 각 라벨에 정보를 뿌려준다
		UILabel *lblTitle = (UILabel *)[cell viewWithTag:100];
		// 배열안에는 dictionary형식으로 데이터를 가지고 있으므로 2중으로 테이터 취득
		NSString *temp = [[arrResult objectAtIndex:indexPath.row] objectForKey:@"title"];
		// 쓸모없는 문자열을 지움 (<b></b> 가 이상하게 표시됨)
		temp = [self htmlEntityDecode:temp];
		// 라벨의 문자열 폰트크기, 색을 설정
		lblTitle.font = [UIFont boldSystemFontOfSize:15];
		lblTitle.textColor = [UIColor blackColor];
		lblTitle.text = temp;
		
		// 위와 같은 설정
		UILabel *lblDesc = (UILabel *)[cell viewWithTag:101];
		temp = [[arrResult objectAtIndex:indexPath.row] objectForKey:@"description"];
		temp = [self htmlEntityDecode:temp];
		lblDesc.font = [UIFont systemFontOfSize:13];
		lblDesc.textColor = [UIColor lightGrayColor];
		lblDesc.text = temp;
		
		UILabel *lblAuth = (UILabel *)[cell viewWithTag:102];
		temp = [[arrResult objectAtIndex:indexPath.row] objectForKey:@"author"];
		temp = [self htmlEntityDecode:temp];
		lblAuth.font = [UIFont systemFontOfSize:12];
		lblAuth.textColor = [UIColor blueColor];
		lblAuth.text = temp;
	}else {
		// 마지막 셀은 스토리보드에서 설정한 셀을 그대로 가져옴
		cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell" forIndexPath:indexPath];
	}
	// 셀이 선택되었을때의 스타일 변경
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate
/**
 *	@brief	셀이 선택되었을때
 *
 *	@param 	tableView 	적용할 테이블
 *	@param 	indexPath 	셀의 위치정보
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// 마지막셀인지 판단
	if (indexPath.row < [arrResult count]) {
		// 웹뷰로 넘어 기기 위해 스토리보드에서 ID로 웹뷰를 지정함
		UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
																 bundle: nil];
		
		WebViewController *controller = (WebViewController*)[mainStoryboard
															 instantiateViewControllerWithIdentifier: @"WebViewController"];
		// 웹뷰에서 표시할 웹싸이트의 주소를 넘겨줌
		controller.strDetailUrl = [[arrResult objectAtIndex:indexPath.row] objectForKey:@"link"];
		// 화면 전이
		[self.navigationController pushViewController:controller animated:YES];
	} else {
		// 마지막셀은 결과값을 더 보는 기능이지만 현재는 구현 하지 않음
		// 경고창을 보여주고 끝냄
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"확인" message:@"더불러오기기능은 아직 구현 전입니다.숙제로 해오실래요?" delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
		[alert show];
	}
}

#pragma mark - User Define Methods

/**
 *	@brief	특수문자를 변환해 준다 <b>, </b>는 삭제해 준다
 *
 *	@param 	string 	변환할 문자열
 *
 *	@return	변환을 마친 문자열을 반환
 */
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
	string = [string stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    
    return string;
}


@end
