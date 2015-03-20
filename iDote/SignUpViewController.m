//
//  SignUpViewController.m
//  iDote
//
//  Created by Jonathan Andrade on 20/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtFieldName;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldConfirmPassword;

@end

@implementation SignUpViewController

-(void) registerUser
{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual: _txtFieldName])
        [_txtFieldEmail becomeFirstResponder];
    else if ([textField isEqual: _txtFieldEmail])
        [_txtFieldPhoneNumber becomeFirstResponder];
    else if ([textField isEqual: _txtFieldPhoneNumber])
        [_txtFieldPassword becomeFirstResponder];
    else if ([textField isEqual:_txtFieldConfirmPassword])
    {
        [self registerUser];
    }
    
    return YES;
}

@end
