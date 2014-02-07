//
//  ViewController.m
//  KJSearch
//
//  Created by IKE on 13. 10. 2..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "ViewController.h"
#define MAX_HISTORY_COUNT 15
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
	arrHistory = [[NSMutableArray alloc] init];
	arrHistory = [self getHistoryWords];
	tvSearchWords.alpha = 0.0f;
	[tvSearchWords setBackgroundView:nil];
	[tvSearchWords setBackgroundColor:[UIColor clearColor]];
	[tvSearchWords setOpaque:NO];
	tvSearchWords.separatorStyle = UITableViewCellSeparatorStyleNone;
	
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) viewWillAppear:(BOOL)animated {
	tfSearchInput.text = @"";
	tfSearchInput.placeholder = @"검색어를 입력해 주세요";
	if (arrHistory != nil) {
		[arrHistory removeAllObjects];
	}
	arrHistory = [self getHistoryWords];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *	@brief	검색버튼을 눌렀을 때의 처리
 *
 *	@param 	sender 	눌려진 버튼
 */
- (IBAction)onSearchBtn:(UIButton *)sender {
	// 키보드는 내리고
	[tfSearchInput resignFirstResponder];
	
	[self hideTableView];
	// 입력된 검색어가 있을 경우에만 반응
	if (![tfSearchInput.text isEqualToString:@""]) {
		[aiLodaingIndicator setAlpha:1.0f];
		[aiLodaingIndicator startAnimating];
		// 검색어보존용 객체에 검색어를 대입
		strSearch = tfSearchInput.text;
		// 다른 스레드로 검색 결과를 받아오는 메소드 호출
		[self performSelector:@selector(startSearch) withObject:nil];
		[self addWordToHistoryFile:strSearch];
	}else {
		if ([arrHistory count] > 0) {
			[aiLodaingIndicator setAlpha:1.0f];
			[aiLodaingIndicator startAnimating];
			tfSearchInput.text = [arrHistory objectAtIndex:0];
			strSearch = tfSearchInput.text;
			[self performSelector:@selector(startSearch) withObject:nil];
		}
	}
	
	
}

/**
 *	@brief	키보드가 표시되어있을때 화면을 터치하면 키보다가 사라지게 하는 메소드
 *
 *	@param 	sender 	UIView(화면의 백그라운드뷰)
 */
- (IBAction)onTouchBackView:(id)sender {
	[self hideTableView];

	// 키보드를 감춘다
	[tfSearchInput resignFirstResponder];
}


/**
 *	@brief	검색을 하기위한 객체들을 준비한다
 */
-(void) startSearch {
	// 검색을 위한 URL 문자열을 만들어 주고
	NSString *strRequest = [NSString stringWithFormat:@"http://apis.daum.net/search/blog?q=%@&output=json&result=20&apikey=5c9ea19b004237cdcfe75de4ac34aef2ee551e4a", strSearch];

	// 한글검색을 위해 UTF8로 인코딩 해줌
	strRequest = [strRequest stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	// 받아올 데이터를 보존할 객체를 초기화 해준다
	responseData = [NSMutableData data];

	// URL통신을 위한 URLRequest객체를 만들어 주고
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strRequest]];
	// URL통신용 객체를 초기화 한다. 연결에 대한 처리는(delegate)는 self에게 맡긴다
	conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark - NSURLConnetionDelegate

/**
 *	@brief	URL통신으로 데이터를 받기 시작
 *
 *	@param 	connection 	연결 객체
 *	@param 	response 	리스폰 데이터의 정보 겍체
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	// 파싱할 데이터를 초기화 한다
    [responseData setLength:0];
}
/**
 *	@brief	데이터가 받아지면 객체에 보관 처리
 *
 *	@param 	connection 	연결 객체
 *	@param 	data 	받아온 데이터
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	// 받아온 데이터를 객체에 더한다
    [responseData appendData:data];
}
/**
 *	@brief	연결이 실패시 처리
 *
 *	@param 	connection 	연결 객체
 *	@param 	error 	에러
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	// 로딩 인디게이터를 멈춘다
	[aiLodaingIndicator stopAnimating];
	[aiLodaingIndicator setAlpha:0.0];
}
/**
 *	@brief	URL통신 종료
 *
 *	@param 	connection 	연결 객체
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	// 로딩 인디게이터를 멈춘다
	[aiLodaingIndicator stopAnimating];
	[aiLodaingIndicator setAlpha:0.0];

	// 받아온 데이터를 NSDictionary로 변환한다
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:responseData
															   options:NSJSONReadingAllowFragments
																 error:nil];
	
	// 화면 전이를 위한 결과화면를 지정
	// 현재 스토리보드 파일을 지정후
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
															 bundle: nil];
	
	// 스토리보드에서 ID로 뷰를 지정
	ResultViewController *controller = (ResultViewController*)[mainStoryboard
													   instantiateViewControllerWithIdentifier: @"ResultViewController"];
	// 검색결과 데이터를 결과화면에 넘겨준다
	controller.arrResult = [[jsonObject objectForKey:@"channel"] objectForKey:@"item"];
	// Navigation을 이용 화면 전이를 한다
	[self.navigationController pushViewController:controller animated:YES];
}
#pragma mark - UITextfield Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
	
	if ([arrHistory count] > 0) {
		[self showTableView];
		[tvSearchWords reloadData];
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (![tfSearchInput.text isEqualToString:@""]) {
		[tfSearchInput resignFirstResponder];
		[self hideTableView];
		strSearch = textField.text;
		[self startSearch];
		[self addWordToHistoryFile:strSearch];
	}
	return YES;
}
#pragma mark - TableView Show / Hide
- (void) showTableView {
	
	[UIView animateWithDuration:0.3 animations:^{
		tvSearchWords.alpha = 1.0f;
	} completion:^(BOOL finished) {
		
	}];
}
- (void) hideTableView {
	[UIView animateWithDuration:0.3 animations:^{
		tvSearchWords.alpha = 0.0f;
	} completion:^(BOOL finished) {
		
	}];
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [arrHistory count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	[cell setBackgroundView:nil];
	[cell setBackgroundColor:[UIColor clearColor]];
	[cell setOpaque:NO];

	cell.textLabel.text = [arrHistory objectAtIndex:indexPath.row];
	CGFloat al = 1 - (0.05 * indexPath.row);
	cell.textLabel.textColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:al];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	strSearch =[arrHistory objectAtIndex:indexPath.row];
	tfSearchInput.text = strSearch;
	[self startSearch];
	
}

- (void) addWordToHistoryFile:(NSString *)searchWord {
	
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_async(queue, ^{
		NSError *error;
		NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"searchHistory.plist"];
		
		NSFileManager *fileManager = [NSFileManager defaultManager];
		
		if(![fileManager fileExistsAtPath:filePath]) {
			NSString *bundle = [[NSBundle mainBundle] pathForResource:@"searchHistory" ofType:@"plist"];
			[fileManager copyItemAtPath:bundle toPath:filePath error:&error];
		}
		
		BOOL isExist = NO;
		int  intExist = 0;
		NSMutableArray *savedStock = [NSMutableArray arrayWithContentsOfFile:filePath];
		
		if ([savedStock count] == 0) {
			[savedStock addObject:searchWord];
		}
		for (NSString *str in savedStock) {
			if([str isEqualToString:searchWord]){
				isExist = YES;
				break;
			}
			intExist ++;
		}
		
		if (isExist == NO) {
			if ([savedStock count] >= MAX_HISTORY_COUNT) {
				[savedStock removeLastObject];
				[savedStock insertObject:searchWord atIndex:0];
			}else{
				[savedStock insertObject:searchWord atIndex:0];
			}
		}else {
			[savedStock removeObjectAtIndex:intExist];
			[savedStock insertObject:searchWord atIndex:0];
		}
		
		[savedStock writeToFile:filePath atomically:YES];
	});
}

- (NSMutableArray *) getHistoryWords {
	
	NSError *error;
	NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"searchHistory.plist"];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if(![fileManager fileExistsAtPath:filePath]) {
		NSString *bundle = [[NSBundle mainBundle] pathForResource:@"searchHistory" ofType:@"plist"];
		[fileManager copyItemAtPath:bundle toPath:filePath error:&error];
	}
	NSMutableArray *savedStock = [NSMutableArray arrayWithContentsOfFile:filePath];
	
	return savedStock;

}



@end
