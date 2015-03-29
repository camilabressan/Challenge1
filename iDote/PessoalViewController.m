//
//  PessoalViewController.m
//  iDote
//
//  Created by Eduardo Santi on 28/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "PessoalViewController.h"

@interface PessoalViewController ()

@end

@implementation PessoalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_user login];
    
    [self showData];
}

-(void)showData{
    _pessoalName.text = _user.name;
    _pessoalEmail.text = _user.email;
}


@end
