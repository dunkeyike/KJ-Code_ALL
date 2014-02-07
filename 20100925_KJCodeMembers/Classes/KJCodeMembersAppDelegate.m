//
//  KJCodeMembersAppDelegate.m
//  KJCodeMembers
//
//  Created by ZipsDev_Ike on 10/08/30.
//  Copyright Zips 2010. All rights reserved.
//

#import "KJCodeMembersAppDelegate.h"
#import "RootViewController.h"
#import "Defines.h"


@implementation KJCodeMembersAppDelegate

@synthesize window;
@synthesize navigationController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    // Add the navigation controller's view to the window and display.
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
	[self createMembers];
	
    return YES;
}


#pragma mark -
#pragma mark User Methods
-(void)createMembers
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *myPath =[documentsDirectory stringByAppendingPathComponent:@"member.plist"];
	
	NSArray *returnArray;
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:myPath]) {
		NSLog(@"Make File!");
		NSArray *developers = [NSArray arrayWithObjects:
							   [NSDictionary dictionaryWithObjectsAndKeys:@"지상훈", @"NameOfMember", @"Developer", @"KindOfMember",@"face_01.png", @"ImageOfMember", @"0", @"IconIndex", @"32", @"AgeOfMember", @"Hibarigaoka", @"AddressOfMember", nil],
							   [NSDictionary dictionaryWithObjectsAndKeys:@"김용석", @"NameOfMember", @"Developer", @"KindOfMember",@"face_02.png", @"ImageOfMember", @"1", @"IconIndex", @"32", @"AgeOfMember", @"Hibarigaoka", @"AddressOfMember",nil],
							   [NSDictionary dictionaryWithObjectsAndKeys:@"이재은", @"NameOfMember", @"Developer", @"KindOfMember",@"face_03.png", @"ImageOfMember", @"2", @"IconIndex", @"32", @"AgeOfMember", @"Hibarigaoka", @"AddressOfMember",nil],
							   [NSDictionary dictionaryWithObjectsAndKeys:@"조형남", @"NameOfMember", @"Developer", @"KindOfMember",@"face_07.png", @"ImageOfMember", @"6", @"IconIndex", @"32", @"AgeOfMember", @"Hibarigaoka", @"AddressOfMember",nil],
							   [NSDictionary dictionaryWithObjectsAndKeys:@"노희동", @"NameOfMember", @"Developer", @"KindOfMember",@"face_05.png", @"ImageOfMember", @"4", @"IconIndex", @"32", @"AgeOfMember", @"Hibarigaoka", @"AddressOfMember",nil],
							   [NSDictionary dictionaryWithObjectsAndKeys:@"최혁순", @"NameOfMember", @"Developer", @"KindOfMember",@"face_06.png", @"ImageOfMember", @"5", @"IconIndex", @"32", @"AgeOfMember", @"Hibarigaoka", @"AddressOfMember",nil],
							   [NSDictionary dictionaryWithObjectsAndKeys:@"양선영", @"NameOfMember", @"Developer", @"KindOfMember",@"face_04.png", @"ImageOfMember", @"3", @"IconIndex", @"32", @"AgeOfMember", @"Hibarigaoka", @"AddressOfMember",nil],
							   nil];
		NSArray *designers = [NSArray arrayWithObjects:
							  [NSDictionary dictionaryWithObjectsAndKeys:@"양인선", @"NameOfMember", @"Designer", @"KindOfMember",@"face_08.png", @"ImageOfMember", @"7", @"IconIndex", @"32", @"AgeOfMember", @"Hibarigaoka", @"AddressOfMember",nil],
							  [NSDictionary dictionaryWithObjectsAndKeys:@"이상희", @"NameOfMember", @"Designer", @"KindOfMember",@"face_09.png", @"ImageOfMember", @"8", @"IconIndex", @"32", @"AgeOfMember", @"Hibarigaoka", @"AddressOfMember",nil],
							  [NSDictionary dictionaryWithObjectsAndKeys:@"앙드레김", @"NameOfMember", @"Designer", @"KindOfMember",@"face_10.png", @"ImageOfMember", @"9", @"IconIndex", @"32", @"AgeOfMember", @"Hibarigaoka", @"AddressOfMember",nil],
							  nil];
		
		
		returnArray = [NSArray arrayWithObjects:developers, designers, nil];
		
		[returnArray writeToFile:myPath atomically:YES];
	}
	else {
		NSLog(@"Read From File!");
	}
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

