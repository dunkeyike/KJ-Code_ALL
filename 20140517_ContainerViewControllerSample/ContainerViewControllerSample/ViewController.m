//
//  ViewController.m
//  ContainerViewControllerSample
//
//  Created by Lee jaeeun on 2014/05/16.
//  Copyright (c) 2014年 kjcode. All rights reserved.
//

#import "ViewController.h"
#import "ChalbangImageViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) UIViewController *startView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    NSLog(@"%s", __FUNCTION__);
    
    self.menuItems = @[@"세계5대난제",@"폭풍코딩",@"심쿵!",@"파견맨"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    
    //첫 스타트할 컨텐츠뷰 설정
    self.startView = [[(UINavigationController *)[self.childViewControllers objectAtIndex:0] childViewControllers] objectAtIndex:0];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
}
- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
}
- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return TableCellTypeMaxCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"tableCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //cell update.
    cell.textLabel.text = [_menuItems objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%d tablecell selected.", indexPath.row);
    
    switch (indexPath.row) {
        case TableCellTypeNanmon:
            [_startView.navigationController popToRootViewControllerAnimated:YES];
            break;
        case TableCellTypeArashi:
            [_startView performSegueWithIdentifier:@"ArashiSegue" sender:self];
            break;
        case tableCellTypeShimKung:
            [_startView performSegueWithIdentifier:@"SimkungSegue" sender:self];
            break;
        case TableCellTypeHakenMan:
            [_startView performSegueWithIdentifier:@"HakenmanSegue" sender:self];
            break;
        default:
            break;
    }
}

@end
