//
//  ViewController.h
//  iDote
//
//  Created by Adriano Soares on 17/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import <Parse/Parse.h>

@interface LoginViewController : UIViewController

@property User *usuario;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *senhaTextField;
@property (weak, nonatomic) IBOutlet UIImageView *logo;

- (IBAction)checkData:(id)sender;


@end

