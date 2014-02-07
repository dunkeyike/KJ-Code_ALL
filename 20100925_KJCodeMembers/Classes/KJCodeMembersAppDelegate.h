//
//  KJCodeMembersAppDelegate.h
//  KJCodeMembers
//
//  Created by ZipsDev_Ike on 10/08/30.
//  Copyright Zips 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJCodeMembersAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (void)createMembers;
@end

