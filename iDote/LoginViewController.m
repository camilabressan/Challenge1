//
//  ViewController.m
//  iDote
//
//  Created by Adriano Soares on 17/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldPassword;

@end

@implementation LoginViewController {

}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  if ([PFUser currentUser] != nil) {
    //TODO: Login Automatico
  }
    
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  if ([segue.identifier isEqualToString:@"MainSegue"] ) {
    //TODO: Enviar Usuario Para Lista
  }
}

//pega os dados inseridos pelo usuario na tela de login e verifica os mesmos
- (IBAction)checkData:(id)sender {
  
  
  _usuario = [[User alloc] init];
  _usuario.email = [_emailTextField.text lowercaseString];
  _usuario.password = _senhaTextField.text;
  [PFUser logInWithUsernameInBackground:_usuario.email password:_usuario.password
            block:^(PFUser *user, NSError *error) {
              if (!error) {
                _usuario.object = user;
                [self performSegueWithIdentifier:@"MainSegue" sender:sender];
              } else {
                  UIAlertView *alertFailLogin = [[UIAlertView alloc] initWithTitle:nil message:@"Seus dados estão incorretos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                  
                  [alertFailLogin show];
              }
    
            }];
   }

- (IBAction)returnKeyboard:(id)sender {
    [self.view endEditing:YES];
}

-(IBAction)backFromRegisterScreen:(UIStoryboardSegue *)sender {
    
}

-(IBAction)saveFromRegisterScreen:(UIStoryboardSegue *)sender {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField isEqual: _txtFieldEmail])
        [_txtFieldPassword becomeFirstResponder];
    else if ([textField isEqual: _txtFieldPassword])
        [self checkData:self];
        
    return YES;
}

@end
