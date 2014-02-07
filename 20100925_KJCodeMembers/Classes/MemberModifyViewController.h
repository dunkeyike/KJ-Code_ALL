//
//  MemberModifyViewController.h
//  KJCodeMembers
//
//  Created by ZipsDev_Ike on 10/09/21.
//  Copyright 2010 Zips. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MemberModifyViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate> {
	UITextField	*nameTextField;
	UITextField	*positionTextField;
	UITextField	*ageTextField;
	UITextField	*addressTextField;
	NSDictionary *memberData;
	NSMutableArray *allMembersData;
	UIBarButtonItem *saveButton;
	NSIndexPath *indexPath;
	
	UIButton *prevButton;
	UIButton *nextButton;
	UIImageView *iconImageView;
	NSArray *iconArray;
	NSInteger iconIndex;
	UILabel *iconName;
}

@property (nonatomic, retain) IBOutlet UITextField	*nameTextField;
@property (nonatomic, retain) IBOutlet UITextField	*positionTextField;
@property (nonatomic, retain) IBOutlet UITextField	*ageTextField;
@property (nonatomic, retain) IBOutlet UITextField	*addressTextField;
@property (nonatomic, retain) NSDictionary *memberData;
@property (nonatomic, retain) NSMutableArray *allMembersData;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *saveButton;
@property (nonatomic, retain) NSIndexPath *indexPath;

@property (nonatomic, retain) IBOutlet UIButton *prevButton;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;
@property (nonatomic, retain) IBOutlet UIImageView *iconImageView;
@property (nonatomic, retain) NSArray *iconArray;
@property (nonatomic, assign) NSInteger iconIndex;
@property (nonatomic, retain) IBOutlet UILabel *iconName;

-(void)releaseKeyBoard;
-(IBAction)backgroungTap:(id)sender;
-(IBAction)toggleNext;
-(IBAction)togglePrev;
@end
