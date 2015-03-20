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

- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if ([emailTest evaluateWithObject:candidate] == YES)
        return YES;
    else
    {
        UIAlertView *alertIncorrectEmail = [[UIAlertView alloc] initWithTitle:@"Email incorreto" message:@"Por favor, insira um e-mail válido." delegate: self cancelButtonTitle:@"OK"otherButtonTitles: nil];
        [alertIncorrectEmail show];
        return NO;
    }
}

-(BOOL) emptyTextFieldExistent
{
    if ([_txtFieldName.text length] == 0 ||
        [_txtFieldEmail.text length] == 0 ||
        [_txtFieldPhoneNumber.text length] == 0 ||
        [_txtFieldPassword.text length] == 0 ||
        [_txtFieldConfirmPassword.text length] == 0)
    {
        UIAlertView *alertEmptyFields = [[UIAlertView alloc] initWithTitle:@"Campos incompletos" message:@"Por favor, preencha todos os campos." delegate: self cancelButtonTitle:@"OK"otherButtonTitles: nil];
        [alertEmptyFields show];
        return YES;
    }
    return NO;
}

- (BOOL) passwordsDoMatch
{
    if ([_txtFieldPassword.text isEqual: _txtFieldConfirmPassword.text])
        return YES;
    else
    {
        UIAlertView *alertPasswordsDontMatch = [[UIAlertView alloc] initWithTitle:@"Senhas diferentes" message:@"Por favor, preencha os campos de senha com o mesmo valor ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertPasswordsDontMatch show];
        return NO;
    }
}


-(void) registerUser
{
    if ([self validateEmail: _txtFieldEmail.text] == YES &&
        [self emptyTextFieldExistent] == NO &&
         [self passwordsDoMatch] == YES)
    {
        _user = [PFUser user];
        _user.username = _txtFieldName.text;
        _user.password = _txtFieldPassword.text;
        _user.email = _txtFieldEmail.text;
        
        [_user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                UIAlertView *alertSignUpError = [[UIAlertView alloc] initWithTitle:@"Sign up error" message:@"An unexpected error ocurred.\nPlease, check your internet connection or try a different username." delegate: self cancelButtonTitle:@"Dismiss"otherButtonTitles: nil];
                [alertSignUpError show];
                return;
            }
            
            if (succeeded) {
                // usuário registrado! falta criar a segue para mudar de tela
                //[self performSegueWithIdentifier:@"UnwindLoginSegue" sender:nil];
                return;
            }
        }];

    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual: _txtFieldName])
        [_txtFieldEmail becomeFirstResponder];
    else if ([textField isEqual: _txtFieldEmail])
        [_txtFieldPhoneNumber becomeFirstResponder];
    else if ([textField isEqual: _txtFieldPhoneNumber])
        [_txtFieldPassword becomeFirstResponder];
    else if ([textField isEqual: _txtFieldPassword])
        [_txtFieldConfirmPassword becomeFirstResponder];
    else if ([textField isEqual:_txtFieldConfirmPassword])
        [self registerUser];
    
    return YES;
}

@end
