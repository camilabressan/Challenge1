//
//  ViewController.m
//  iDote
//
//  Created by Adriano Soares on 17/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "LoginViewController.h"
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldPassword;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottom;

@end

@implementation LoginViewController {
 
    CGFloat _initialConstant; //CODIGO CAMILA
    UINavigationController *_navController;
    User *_user;
    
}

static CGFloat keyboardHeightOffset = 15.0f; //Camila

- (void)viewDidLoad {
  [super viewDidLoad];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //MUDANDO A COR DO BOTAO PADRAO DA NAVIGATION
    
    
    //CODIGO CAMILA
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notification {
    
    // Getting the keyboard frame and animation duration.
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    NSTimeInterval keyboardAnimationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (!_initialConstant) {
        _initialConstant = _constraintBottom.constant;
    }
    
    // If screen can fit everything, leave the constant untouched.
    _constraintBottom.constant = MAX(keyboardFrame.size.height + keyboardHeightOffset, _initialConstant);
    [UIView animateWithDuration:keyboardAnimationDuration animations:^{
        // This method will automatically animate all views to satisfy new constants.
        [self.view layoutIfNeeded];
    }];
    
}

- (void)keyboardWillHide:(NSNotification*)notification {
    
    // Getting the keyboard frame and animation duration.
    NSTimeInterval keyboardAnimationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // Putting everything back to place.
    _constraintBottom.constant = _initialConstant;
    [UIView animateWithDuration:keyboardAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
} //fim codigo camila

- (IBAction)dismissKeyboard:(id)sender {
    
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self performSelector:@selector(fadeAnimation) withObject:nil afterDelay:1.0];
}

-(void)fadeAnimation
{
    [UIView transitionWithView:self.logo duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        [self.logo setImage:[UIImage imageNamed:@""]];
        
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(fadeAnimation) withObject:nil afterDelay:1.0];
        
    }];
}


/*
 //Animaçao da tela inicial
 -(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([PFUser currentUser] != nil) {
        //[self performSegueWithIdentifier:@"MainSegue" sender:nil];
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
*/

- (IBAction)loginFacebook:(id)sender {
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"email"];
    
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [PFFacebookUtils logInInBackgroundWithAccessToken:[FBSDKAccessToken currentAccessToken]
            block:^(PFUser *user, NSError *error) {
                if (!user) {
                    NSLog(@"Uh oh. The user cancelled the Facebook login.");
                } else if (user.isNew) { //Outro Usuario com email
                    [user deleteInBackground];
                    [PFUser logOut];
                } else {
                    [self performSegueWithIdentifier:@"MainSegue" sender:sender];
                }
            }];
    
    } else {
        [login logInWithReadPermissions:permissionsArray handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                // Process error
            } else if (result.isCancelled) {
                // Handle cancellations
            } else {
                // If you ask for multiple permissions at once, you
                // should check if specific permissions missing
                if ([result.grantedPermissions containsObject:@"email"]) {
                    PFQuery *query = [PFUser query];
                    if ([FBSDKAccessToken currentAccessToken]) {
                        [FBSDKProfile enableUpdatesOnAccessTokenChange:true];
                        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
                         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                             if (!error) {
                                 [query whereKey:@"email" equalTo:result[@"email"]];
                                 [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                     if (!error) {
                                         if (objects.count > 0) { //Usuario com o email já cadastrado
                                            NSLog(@"Usuario já cadastrado!");
                                             [PFFacebookUtils logInInBackgroundWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                                 block:^(PFUser *user, NSError *error) {
                                                     if (!user) {
                                                         NSLog(@"Uh oh. The user cancelled the Facebook login.");
                                                     } else if (user.isNew) { //Outro Usuario com email
                                                         [user deleteInBackground];
                                                     } else {
                                                         [self performSegueWithIdentifier:@"MainSegue" sender:sender];
                                                     }
                                                 }];
                                         } else {
                                             [PFFacebookUtils logInInBackgroundWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                                 block:^(PFUser *user, NSError *error) {
                                                     if (!user) {
                                                         NSLog(@"Uh oh. The user cancelled the Facebook login.");
                                                     } else if (user.isNew) {
                                                         dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
                                                         dispatch_async(queue, ^{
                                                             NSString *imageString = @"https://graph.facebook.com/userId/picture?width=300&height=300";
                                                             imageString = [imageString stringByReplacingOccurrencesOfString:@"userId"
                                                                                                                  withString:result[@"id"]];
                                                             NSURL *imageURL = [[NSURL alloc] initWithString:imageString];
                                                             NSData *imageData = [NSData dataWithContentsOfURL: imageURL];
                                                             PFFile *imageFile = [PFFile fileWithName:@"Profileimage.png" data:imageData];
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                 [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                                                     if (!error) {
                                                                         if (succeeded) {
                                                                             user[@"mainPhoto"] = imageFile;
                                                                             user.username = result[@"email"];
                                                                             user.email = result[@"email"];
                                                                             user[@"Name"] = result[@"name"];
                                                                             [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                                                                 if (succeeded) {
                                                                                     [self performSegueWithIdentifier:@"MainSegue" sender:sender];
                                                                                 }
                                                                             }];
                                                                             
                                                                         }
                                                                     }
                                                                 }];
                                                             });
                                                         });
                                                     }
                                                 }];
                                         }
                                     }
                                 }];
                             }
                         }];
                    }
                }
            }
        }];
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
    _txtFieldEmail.text = @"";
    _txtFieldPassword.text = @"";
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
