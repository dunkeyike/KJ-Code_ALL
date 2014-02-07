//
//  ViewController.h
//  BlockSampleApplication
//
//  Created by Lee jaeeun on 2013/11/09.
//  Copyright (c) 2013年 kjcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Human.h"

@interface ViewController : UIViewController <HumanDelegate>

@property (nonatomic, strong) Human *man;
@property (nonatomic, strong) Human *woman;
@property (nonatomic, strong) Human *gay;

@end
