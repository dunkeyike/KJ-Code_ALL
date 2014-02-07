//
//  ViewController.h
//  TableViewTest
//
//  Created by IKE on 13. 8. 17..
//  Copyright (c) 2013년 Dunkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	IBOutlet UITableView			*tvList;
}
@end
