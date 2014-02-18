//
//  NSUserDefaults+Addition.h
//  UIviewConCategory
//
//  Created by Dunkey on 2014. 2. 12..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Addition)

// it used by class method
+ (NSString*) getUserName;
+ (void) setUserName:(NSString*)userName;
+ (void) sync;

@end
