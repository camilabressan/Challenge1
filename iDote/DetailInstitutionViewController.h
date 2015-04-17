//
//  DetailInstitutionViewController.h
//  iDote
//
//  Created by Eduardo Santi on 25/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Institution.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface DetailInstitutionViewController : UIViewController

@property Institution *inst;

@property (weak, nonatomic) IBOutlet UILabel *nameDetail;
@property (weak, nonatomic) IBOutlet UILabel *phoneDetail;
@property (weak, nonatomic) IBOutlet UILabel *emailDetail;
@property (weak, nonatomic) IBOutlet UILabel *responsibleDetail;
@property (weak, nonatomic) IBOutlet UILabel *addressDetail;
@property (weak, nonatomic) IBOutlet UITextView *descriptionDetail;


@end
