//
//  ViewController.m
//  TableViewTest_0901
//
//  Created by IKE on 13. 9. 1..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{

	
	// 데이터 초기 세팅
	// 문자열 데이터 초기값 대입
	dataForSection0 = @"기본셀 집합 섹션입니다.";
    dataForSection2 = @"여기도 기본 셀 섹션";
	// 배열의 초기화
	demoData = [[NSMutableArray alloc] init];
	[demoData addObject:@"하나"];
	[demoData addObject:@"둘"];
	[demoData addObject:@"셋"];
	[demoData addObject:@"넷"];
	[demoData addObject:@"다섯"];

	NSLog(@"Array : %@",demoData);
	// 다른 방법
//	demoData = [[NSMutableArray alloc] initWithObjects:@"하나",@"둘",@"셋",@"넷",@"다섯", nil];
	
	// 플래ㅅ그와 인덱스 변수 초기화
	isShowList = NO;			// 처음 기동시에는 닫혀있음
	selectedIndex = 0;			// 처음 기동시에는 0번째 셀이 선택됨
	
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView DataSource Methods
// 섹션 갯수 설정
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 3;
}
// 각 섹션의 셀의 갯수 설정
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// 0,2번째 섹션은 하나의 셀만 가지고 있으므로 1을 리턴
	if(section == 0 || section == 2) {
		return 1;
	}else{				// 1번째 섹션은 셀의 갯수가 가변이므로
		// 닫혀있으면 1개
		if(!isShowList){
			return 1;
		// 열려있으면 1번째 섹션이 가지고 있는 데이터수만큼의 셀객수를 리턴
		}else{
			return [demoData count];
		}
	}
}
// 각 섹션의 타이틀 설정
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"1번째 섹션";
    }
    else if (section == 1){
        return @"2번째 섹션 - 드롭다운셀";
    }
    else{
        return @"3번째 섹션";
    }
}

// 셀의 높이 설정
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 45.0;
}

// 각각의 셀을 구성
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// 셀의 ID 설정
    static NSString *CellIdentifier = @"Cell";
    
	// 셀의 ID를 가지고 재사용가능한 셀이 있는지 판단
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
	// 재사용가능한 셀이 없으면
    if (cell == nil) {
		// 셀의 ID를 세팅하여 셀을 생성
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	// 셀의 설정 세팅
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;		// 셀이 선택되어지면 배경을 파랗게 되게함
//	cell.selectionStyle = UITableViewCellSelectionStyleGray;		// 셀의 선택되어질때의 스타일은 총 3가지		그래이
//	cell.selectionStyle = UITableViewCellSelectionStyleNone;		// 색 변화 없음
	
	// 셀의 악세사리 타입 설정
    cell.accessoryType = UITableViewCellAccessoryNone;				// 설정하지 않으면 UITableViewCellAccessoryNone 로 설정됨
	
	// 셀의 악세사리 설정은 총 4가지
//	cell.accessoryType = UITableViewCellAccessoryCheckmark;					// 체크마크
//	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;	// 파란동그라미안에 화살표
//	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;		// 그냥 화살표
	
    
	// 0번 섹션의 셀 설정 - 단순 텍스트 표시
    if ([indexPath section] == 0) {
		// 지금까지 텍스트 설정과는 다른 방법
		// 두가지 다 결과는 같음
        [[cell textLabel] setText:dataForSection0];			// OBJ-C 식의 메소드 호출 & 변수 대입방법
//		cell.textLabel.text = dataForSection0;				// 기존 방식의 메소드 호출 & 변수 대입방법
    }
	// 2번 섹션의 셀 설정 - 단순 텍스트 표시
    else if ([indexPath section] == 2){
        [[cell textLabel] setText:dataForSection2];
    }
	// 1번 섹션의 셀 설정
    else{
		// 셀이 닫혀있으면
        if (!isShowList) {
			// 선택된(마직막에 선택된) 셀의 인덱스의 테이터를 표시
            [[cell textLabel] setText:[demoData objectAtIndex:selectedIndex]];
			// 악세사리뷰를 체크마크로 설정
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
		// 셀이 열려있으면
        else{
			// 각셀에 각각의 데이터를 표시
            [[cell textLabel] setText:[demoData objectAtIndex:[indexPath row]]];
			// 이전에 선택된 셀이라면
			if ([indexPath row] == selectedIndex) {
				// 악세사리뷰를 체크마크로 설정
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
			// 선택된 셀이 아니라면
            else{
				// 악세사리뷰에 아무것도 표시 하지않음
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    }
    return cell;
}


// 셀이 선택되어지면 호출되는 메소드
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	// 1번째 섹션의 셀이 선택될때만 반응
    if ([indexPath section] == 1) {
		// 셀이 열려있으면
        if (isShowList) {
			// 선택한 셀의 인덱스를 보관한다
            selectedIndex = [indexPath row];
        }
		// 열려있는 상태를 반전시킨다		열려있음<->닫혀있음
        isShowList = !isShowList;
        
		// 해당 셋션을 업데이트 한다
        [tvTempTableView reloadSections:[NSIndexSet indexSetWithIndex:1]
					   withRowAnimation:UITableViewRowAnimationFade];
		
		// 비슷한 메소드들로 이하와같은 메소드들이 있으며
		// 섹션을 추가하는 메소드, 에니메이션을 추가 할수 있다
//		- (void)insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;

		// 섹션을 지우는 메소드, 에니메이션을 추가 할수 있다
//		- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;

		// 현재 호출하는 메소드, 에니메이션을 추가 할수 있다
		// 뒤에있는  NS_AVAILABLE_IOS(3_0) 는 ios버전 3.0 부터 사용할수 있는 메소드라는 뜻이다.
//		- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation NS_AVAILABLE_IOS(3_0);
		
		// 섹션을 이동시킬때 호출하는 메소드
		// 뒤에있는  NS_AVAILABLE_IOS(5_0) 는 ios버전 5.0 부터 사용할수 있는 메소드라는 뜻이다.
//		- (void)moveSection:(NSInteger)section toSection:(NSInteger)newSection NS_AVAILABLE_IOS(5_0);

		// 참고로 셀을 추가 하거나 삭제 하는 메소드들도 존재함
		// 셀 추가, 애니메이션화 가능
//		- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
		
		// 셀 삭제, 애니메이션화 가능
//		- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
		
		// 셀 상태 업데이트, 애니메이션화 가능
//		- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation NS_AVAILABLE_IOS(3_0);
		
		// 셀 이동
//		- (void)moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath NS_AVAILABLE_IOS(5_0);


		
		// UITableViewRowAnimation 종류들
//		UITableViewRowAnimationFade,
//		UITableViewRowAnimationRight,
//		UITableViewRowAnimationLeft,
//		UITableViewRowAnimationTop,
//		UITableViewRowAnimationBottom,
//		UITableViewRowAnimationNone,            // available in iOS 3.0
//		UITableViewRowAnimationMiddle,          // available in iOS 3.2.  attempts to keep cell centered in the space it will/did occupy
//		UITableViewRowAnimationAutomatic = 100  // available in iOS 5.0.  chooses an appropriate animation style for you

    }
	
	// 1번째 셀이외에는 아마 반응없음
    else{
        return;
    }
    
}
@end
