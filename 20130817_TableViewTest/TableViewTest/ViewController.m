//
//  ViewController.m
//  TableViewTest
//
//  Created by IKE on 13. 8. 17..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat retVal = 0;
	if (indexPath.section == 0) {
		retVal = 100;
	}
	if (indexPath.section == 1) {
		retVal = 50;
	}
	if (indexPath.section == 2) {
		retVal = 50;
	}
	return retVal;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *strTitle = [NSString stringWithFormat:@"%d Section", section];
	return strTitle;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger retVal = 0;
	if (section == 0) {
		retVal = 10;
	}
	if (section == 1) {
		retVal = 10;
	}
	if (section == 2) {
		retVal = 20;
	}
	return retVal;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
	tempView.backgroundColor = [UIColor orangeColor];
	
	UILabel	*lblSectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
	lblSectionTitle.text = [NSString stringWithFormat:@"%d", section];
	lblSectionTitle.center = tempView.center;
	lblSectionTitle.backgroundColor = [UIColor clearColor];
	[tempView addSubview:lblSectionTitle];
	return tempView;
	
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSLog(@"indexPath : %@",indexPath);
	NSLog(@"section : %d",indexPath.section);
	NSLog(@"row : %d",indexPath.row);
	
	static NSString *Section0Id = @"Section0Id";
	static NSString *Section1Id = @"Section1Id";
	static NSString *Section2Id = @"Section2Id";
    
	
	if (indexPath.section == 0) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Section0Id];
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Section0Id];
		}
		
		float rowGreen = 0.1 * indexPath.row;
		UIColor	*bgColor = [UIColor colorWithRed:1 green:rowGreen blue:0 alpha:1];
		
		
		cell.textLabel.text = [NSString stringWithFormat:@"%d, %d번째 셀", indexPath.section, indexPath.row];
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.detailTextLabel.backgroundColor = [UIColor clearColor];
		cell.imageView.image = [UIImage imageNamed:@"00_icon_activity_rate"];
		cell.contentView.backgroundColor = bgColor;
		
		cell.detailTextLabel.text = [NSString stringWithFormat:@"Sec : %d, Row : %d", indexPath.section, indexPath.row];

		
		return cell;

	}
	
	if (indexPath.section == 1) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Section1Id];
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Section1Id];
		}
		
		CGFloat rowGreen = 0.1 * indexPath.row;
		UIColor	*bgColor = [UIColor colorWithRed:0 green:rowGreen blue:1 alpha:1];

		cell.textLabel.text = [NSString stringWithFormat:@"%d, %d번째 셀", indexPath.section, indexPath.row];
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.detailTextLabel.backgroundColor = [UIColor clearColor];
		cell.detailTextLabel.textColor = [UIColor colorWithRed:1-(rowGreen) green:1-(rowGreen) blue:1-(rowGreen) alpha:1];
		cell.imageView.image = [UIImage imageNamed:@"00_icon_activity_rate"];
		
		cell.contentView.backgroundColor = bgColor;
		cell.detailTextLabel.text = [NSString stringWithFormat:@"Sec : %d, Row : %d", indexPath.section, indexPath.row];
				
		return cell;

	}
	
	if (indexPath.section == 2) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Section2Id];
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:Section2Id];
		}
		if (indexPath.row % 2 == 0) {
			CGFloat rowBlue = 0.05 * indexPath.row;
			UIColor	*bgColor = [UIColor colorWithRed:rowBlue green:1 blue:0 alpha:1];
			cell.contentView.backgroundColor = bgColor;
		}else{
			cell.contentView.backgroundColor = [UIColor	whiteColor];
		}

		cell.textLabel.text = [NSString stringWithFormat:@"%d, %d번째 셀", indexPath.section, indexPath.row];
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.detailTextLabel.text = [NSString stringWithFormat:@"Sec : %d, Row : %d", indexPath.section, indexPath.row];
		cell.detailTextLabel.backgroundColor = [UIColor clearColor];
		
		return cell;

	}

	return nil;
}

#pragma mark - UITableView Delagate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
	NSString *strTitle = cell.textLabel.text;
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:strTitle delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	[alert show];
	
}
@end
