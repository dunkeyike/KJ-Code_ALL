//
//  RootViewController.m
//  KJCodeMembers
//
//  Created by ZipsDev_Ike on 10/08/30.
//  Copyright Zips 2010. All rights reserved.
//

#import "RootViewController.h"
#import "KJCodeMembersAppDelegate.h"
#import "MemberDetailViewController.h"

@implementation RootViewController
@synthesize members;
@synthesize isEdited;


#pragma mark -
#pragma mark View lifecycle

-(void) viewWillAppear:(BOOL)animated
{
	[self.tableView reloadData];
}
// 뷰가 처음 불려질때 처리하는 메소드
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"KJ-Code Members";
	self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f) style:UITableViewStyleGrouped];
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	self.tableView.rowHeight = 60;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *myPath =[documentsDirectory stringByAppendingPathComponent:@"member.plist"];
	
	members = [[NSMutableArray arrayWithContentsOfFile:myPath] retain];
	
	isEdited = NO;	
}

#pragma mark -
#pragma mark Table view data source

// 섹션 수
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [members count];
}


// 각섹션에 있는 로우(셀)의 수 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//	int returnCount = [[[self appDelegate].memberArray objectAtIndex:section] count];
	return [[members objectAtIndex:section] count];
}


// 각셀의 내용을 넣어서 뿌려준다..
// 각셀은 CellIdentifier 에 의해서 재사용된다.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MemberTableCell" owner:self options:nil];
		cell = [topLevelObjects objectAtIndex:0];
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	// 이름, 소속, 그림, 셀 악세사리 넣기.
//	cell.textLabel.text = [[[members objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] objectForKey:@"NameOfMember"];
//	cell.detailTextLabel.text = [[[members objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]objectForKey:@"KindOfMember"];
//		
//	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
//	
//	UIImage *tumb = [UIImage imageNamed:[[[members objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] objectForKey:@"ThumbnailOfMember"]];
//	cell.imageView.image = tumb;
	
	UILabel *label;
	label = (UILabel *)[cell viewWithTag:2];
	label.text = [[[members objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] valueForKey:@"NameOfMember"];
	
	label = (UILabel *)[cell viewWithTag:3];	
    label.text = [[[members objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] valueForKey:@"KindOfMember"];
	
	label = (UILabel *)[cell viewWithTag:4];	
    label.text = [[[members objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] valueForKey:@"AgeOfMember"];
	
	label = (UILabel *)[cell viewWithTag:5];	
    label.text = [[[members objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] valueForKey:@"AddressOfMember"];
	
	UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
	UIImage *tumb = [UIImage imageNamed:[[[members objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] objectForKey:@"ImageOfMember"]];
	imageView.image = tumb;
	return cell;
}

// 각셀의 헤더 타이틀을 설정
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *returnString;
	switch (section) {
		case DEVELOPER_SECTION:
			returnString = @"Developers";
			break;
		case DESIGNER_SECTION:
			returnString = @"Designers";
			break;
	}
	return returnString;
}

// 각 섹션의 푸터 타이틀을 설정
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	NSString *returnString;
	switch (section) {
		case DEVELOPER_SECTION:
			returnString =[NSString stringWithFormat:@"개발자 %d명",[[members objectAtIndex:section] count]];
			break;
		case DESIGNER_SECTION:
			returnString =[NSString stringWithFormat:@"디자이너 %d명",[[members objectAtIndex:section] count]];
			break;
	}
	return returnString;}


#pragma mark -
#pragma mark Table view delegate

// 셀이 선택되었을때 처리하는 메소드
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// 이거 지우면 셀 선택시 파란색으로 바뀐상태로 계속 남아 있음.
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	MemberDetailViewController *detailView = [[MemberDetailViewController alloc] initWithNibName:@"MemberDetailViewController" bundle:nil];
	NSDictionary *memberData = [[members objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	detailView.allMembersData = members;
	detailView.memberData = memberData;
	detailView.indexPath = indexPath;
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Members" style:UIBarButtonItemStyleBordered target:self action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[self.navigationController pushViewController:detailView animated:YES];
	[detailView release];
	[backButton release];
	
	
	//셀이 선택된후에 선택된 상태를 지우때 딜레이를 설정해서 실행할라면 여기 실행 
	//[self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f]; 
	
	
}

// 커스텀 디셀렉트 메소드
- (void)deselect
{
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}


// 에디트 버튼을 누렀을때 어떤 에디트 모드로 실행 할지 정하는 메소드
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
	//	return UITableViewCellEditingStyleInsert;
	//	return UITableViewCellEditingStyleNone;
}

// 에디트 모드별로 처리를 하는 메소드
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{	
	// 데이터 삭제
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[[members objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
		isEdited = YES;
	// 데이터 추가
	}else if (editingStyle == UITableViewCellEditingStyleInsert) {
		// TO DO Add Data
	}
}


// 에디트 모드시에 이동도 가능하게 할지여부 결정하는 메소드. 디폴트 YES
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

// 에디트 버튼을 눌렀을때 발생하는 이벤트
- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *myPath =[documentsDirectory stringByAppendingPathComponent:@"member.plist"];

	[super setEditing:editing animated:animate];
    if(editing)
    {
        NSLog(@"editMode on");
		isEdited = NO;
    }
    else
    {
		if (isEdited) {
			// 여기서 최종적으로 파일 저장
			[members writeToFile:myPath atomically:YES];
			NSLog(@"File reWrite Complete!!");
		}
		else {
			NSLog(@"No Edited!! No reWrite File!");
		}
    }
}


// 데이터 이동 구현 메소드
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
	NSLog(@"%s", __FUNCTION__);
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *myPath =[documentsDirectory stringByAppendingPathComponent:@"member.plist"];

	id object = [[[members objectAtIndex:fromIndexPath.section] objectAtIndex:fromIndexPath.row]retain];
	
	[[members objectAtIndex:fromIndexPath.section]removeObjectAtIndex:fromIndexPath.row];
	
	// 이동한곳이 같은 섹션이 아닐경우
	if (toIndexPath.section != fromIndexPath.section)
	{
		// 개발자 섹션으로 넘어왔을 경우
		if (toIndexPath.section == DEVELOPER_SECTION) {
			NSDictionary *tempDic = 
			[NSDictionary dictionaryWithObjectsAndKeys:
			 [object valueForKey:@"NameOfMember"], @"NameOfMember",
			 @"Developer", @"KindOfMember",
			 [object valueForKey:@"ImageOfMember"], @"ImageOfMember",
			 [object valueForKey:@"AgeOfMember"], @"AgeOfMember",
			 [object valueForKey:@"AddressOfMember"], @"AddressOfMember", nil];
			[[members objectAtIndex:toIndexPath.section] insertObject:tempDic atIndex:toIndexPath.row];
			[members writeToFile:myPath atomically:YES];
		}
		// 디자이너 섹션으로 넘어왔을 경우
		else if (toIndexPath.section == DESIGNER_SECTION) {
			NSDictionary *tempDic = 
			[NSDictionary dictionaryWithObjectsAndKeys:
			 [object valueForKey:@"NameOfMember"], @"NameOfMember",
			 @"Designer", @"KindOfMember",
			 [object valueForKey:@"ImageOfMember"], @"ImageOfMember",
			 [object valueForKey:@"AgeOfMember"], @"AgeOfMember",
			 [object valueForKey:@"AddressOfMember"], @"AddressOfMember", nil];
			[[members objectAtIndex:toIndexPath.section] insertObject:tempDic atIndex:toIndexPath.row];
			[members writeToFile:myPath atomically:YES];
		}
	}
	// 이동한곳이 같은 섹션일 경우
	else {
		[[members objectAtIndex:toIndexPath.section] insertObject:object atIndex:toIndexPath.row];
	}
	[object release];
	isEdited = YES;
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Alert Delegate

// 경고창 버튼 선택에 따라 처리하는 메소드
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex) {
		case 0:
			NSLog(@"Cancel Button Clicked");
			break;
		case 1:
			NSLog(@"OK Button Clicked");
			break;
	}
	// TO DO
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

