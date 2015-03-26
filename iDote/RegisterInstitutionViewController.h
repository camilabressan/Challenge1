//
//  RegisterInstitutionViewController.h
//  iDote
//
//  Created by Tainara Specht on 3/23/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Institution.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface RegisterInstitutionViewController : UIViewController <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtFieldInstitutionName;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldInstitutionPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldInstitutionEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldInstitutionResponsible;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldInstitutionAddress;
@property (weak, nonatomic) IBOutlet UITextView *txtViewInstitutionDescription;
@property (nonatomic, weak) NSString *email;
@property (weak, nonatomic) IBOutlet UIButton *addInstPic;



@end
