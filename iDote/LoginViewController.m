//
//  ViewController.m
//  iDote
//
//  Created by Adriano Soares on 17/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  if ([PFUser currentUser] != nil) {
    //TODO: Login Automatico
  }
  
  PFUser *user = [[PFUser alloc] init];
  user.username = @"teste@teste.com";
  user.password = @"teste1234";
  [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    
  }];
    
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

//pega os dados inseridos pelo usuario na tela de login e verifica os mesmos
- (IBAction)checkData:(id)sender {
    _usuario = [[User alloc] init];
    _usuario.email = _emailTextField.text;
    _usuario.senha = _senhaTextField.text;
  
  [_usuario login];
  
    
    
}
@end
