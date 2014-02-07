//
//  ViewController.h
//  CFShareCircle
//
//  Created by Camden on 12/18/12.
//  Copyright (c) 2012 Camden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import "CFShareCircleView.h"
#import "KakaoLinkCenter.h"

enum shareMode {
	eShareModeEmail = 0,
	eShareModeFacebook = 1,
	eShareModeTwitter = 2,
	eShareModeKakaoURL = 3,
	eShareModeKakaoAPP = 4,
	eShareModeLine = 5,
};

@interface ViewController : UIViewController <CFShareCircleViewDelegate, MFMailComposeViewControllerDelegate, UIAlertViewDelegate>{
    CFShareCircleView				*shareCircleView;
	MFMailComposeViewController		*mailComposeController;
	
}

- (IBAction)shareButtonClicked:(id)sender;

@end
