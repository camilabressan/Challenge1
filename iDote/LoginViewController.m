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
  // Do any additional setup after loading the view, typically from a nib.
    
    //CODIGO CAMILA
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

//CODIGO CAMILA
- (IBAction)dismissKeyboard {
    
    // This method will resign all responders, dropping the keyboard.
    [self.view endEditing:YES];
    
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

- (IBAction)clickRegisterButton:(id)sender {
    FXFormViewController *controller = [[FXFormViewController alloc] init];
    controller.formController.form = [[User alloc] init];
    
    _navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
    controller.navigationItem.title = @"Dados do Evento";
    controller.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Salvar" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    
    [self presentViewController:_navController animated:YES completion:nil];
}

- (void)dismiss:(id)sender {
    [_navController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)save:(id)sender {
    FXFormViewController *formQueVoltou = (FXFormViewController*)_navController.topViewController;
    _user = formQueVoltou.formController.form;
    
    if ([self emptyTextFieldExistent] == NO &&
        [self validateEmail: _user.email] == YES &&
        [self passwordsDoMatch] == YES &&
        [self phoneIsValid] == YES &&
        _user.phone != nil){
        
        [_user save];
        [_navController dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

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
    if (_user.name == nil ||
        _user.email == nil ||
        _user.phone == nil ||
        _user.password == nil ||
        _user.confirmPassword == nil)
    {
        UIAlertView *alertEmptyFields = [[UIAlertView alloc] initWithTitle:@"Campos incompletos" message:@"Por favor, preencha todos os campos." delegate: self cancelButtonTitle:@"OK"otherButtonTitles: nil];
        [alertEmptyFields show];
        return YES;
    }
    return NO;
}

- (BOOL) passwordsDoMatch
{
    if ([_user.password isEqualToString: _user.confirmPassword])
        return YES;
    else
    {
        UIAlertView *alertPasswordsDontMatch = [[UIAlertView alloc] initWithTitle:@"Senhas diferentes" message:@"Por favor, preencha os campos de senha com o mesmo valor ." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertPasswordsDontMatch show];
        return NO;
    }
}

- (BOOL) phoneIsValid{
    if ([_user.phone length] < 10)
    {
        UIAlertView *alertPhoneInvalid = [[UIAlertView alloc] initWithTitle:@"Telefone inválido" message:@"Por favor, um número de telefone válido (com prefixo)." delegate: self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertPhoneInvalid show];
        return NO;
    }
    return YES;
}

@end
