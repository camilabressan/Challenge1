//
//  PessoalViewController.h
//  iDote
//
//  Created by Eduardo Santi on 28/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface PessoalViewController : UIViewController

@property User *user;

@property (weak, nonatomic) IBOutlet UIButton *pessoalPhoto;
@property (weak, nonatomic) IBOutlet UITextField *pessoalName;
@property (weak, nonatomic) IBOutlet UITextField *pessoalEmail;
@property (weak, nonatomic) IBOutlet UITextField *pessoalPhone;

-(void) showData;

@end
