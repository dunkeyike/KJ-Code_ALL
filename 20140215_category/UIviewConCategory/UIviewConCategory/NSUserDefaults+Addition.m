//
//  NSUserDefaults+Addition.m
//  UIviewConCategory
//
//  Created by Dunkey on 2014. 2. 12..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "NSUserDefaults+Addition.h"

@implementation NSUserDefaults (Addition)

+ (NSString*) getUserName
{
    NSString *result = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    return result;
}

+ (void)setUserName:(NSString*)userName
{
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
//	[self sync];
}

+ (void) sync {
	[[NSUserDefaults standardUserDefaults] synchronize];
}
@end
