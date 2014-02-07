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
	return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
	cell.textLabel.text = [NSString stringWithFormat:@"section : %d, row : %d", indexPath.section, indexPath.row];
	cell.imageView.image = [UIImage imageNamed:@"imgres.jpeg"];
	cell.accessoryView.backgroundColor = [UIColor blueColor];
	cell.contentView.backgroundColor = [UIColor yellowColor	];
	cell.detailTextLabel.text = @"detailTextLabel";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"section : %d, row : %d", indexPath.section, indexPath.row);
	NSLog(@"%s", __FUNCTION__);
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OK" message:@"지금 셀을 터치 하였습니다." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	[alert show];
}
@end
