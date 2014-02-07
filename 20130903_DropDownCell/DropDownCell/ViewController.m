//
//  ViewController.m
//  DropDownCell
//
//  Created by IKE on 13. 9. 3..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{

	arrList = [[NSMutableArray alloc]init];
	[arrList addObject:@"하나"];
	[arrList addObject:@"둘"];
	[arrList addObject:@"셋"];
	[arrList addObject:@"넷"];
	[arrList addObject:@"다섯"];
	
	intSelectIndex = 0;
	
	isCellOpen = NO;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger retVal = 1;

	if (section == 1) {
		if(isCellOpen){
			retVal = [arrList count];
		}
		
	}
	
	return retVal;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *retStr;
	if(section == 0){
		retStr = @"1번째 섹션입니다.";
	}
	if(section == 1){
		retStr = @"2번째 섹션입니다.";
	}
	if(section == 2){
		retStr = @"3번째 섹션입니다.";
	}
	return retStr;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
	cell.accessoryType = UITableViewCellAccessoryNone;
	
	if (indexPath.section == 0) {
		[[cell textLabel] setText:@"기본셀입니다."];
	}
	if (indexPath.section == 1) {
		if (isCellOpen) {
			cell.textLabel.text = [arrList objectAtIndex:indexPath.row];
			if (indexPath.row == intSelectIndex) {
				cell.accessoryType = UITableViewCellAccessoryCheckmark;
			}else {
				cell.accessoryType = UITableViewCellAccessoryNone;
			}
		}else {
			cell.textLabel.text = [arrList objectAtIndex:intSelectIndex];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
	}
	if (indexPath.section == 2) {
		[[cell textLabel] setText:@"기본셀입니다."];
	}
	
	return cell;
}

#pragma mark - UITableView Delegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 1) {
		if(isCellOpen) {
			intSelectIndex = indexPath.row;
		}
		isCellOpen = !isCellOpen;
		NSLog(@"intSelectIndex : %d",intSelectIndex);

		[tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
	}
}

@end
