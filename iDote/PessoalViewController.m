//
//  PessoalViewController.m
//  iDote
//
//  Created by Eduardo Santi on 28/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "PessoalViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>

@interface PessoalViewController () <UITextFieldDelegate>

@property NSMutableArray *listAnimals;
@property (weak, nonatomic) IBOutlet VMaskTextField *maskTextFieldTelephone;


@end

@implementation PessoalViewController

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.maskTextFieldTelephone.mask = @"(##) ####-#####";
    
    _user = [User loadCurrentUser];
    [self loadData];
    
    _tableView.allowsSelection = NO;
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];

    [self.tableView addSubview:_refreshControl];
    [_tableView reloadData];
    [self showData];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField isEqual: _pessoalPhone])
    {
        [self profileDataChanged:self];
        return  [_maskTextFieldTelephone shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
    
}

- (IBAction)linkFacebookAccount:(id)sender {
    NSArray *permissionsArray = @[ @"user_about_me", @"email"];
    if (![PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        [PFFacebookUtils linkUserInBackground:[PFUser currentUser] withReadPermissions:permissionsArray];
    }
    
}

-(void)showData{
    _pessoalName.text = _user.name;
    _pessoalEmail.text = _user.email;
    _pessoalPhone.text = _user.phone;
    
    
    if (_user.mainImage == nil) {
        NSURL *imageURL = [[NSURL alloc] initWithString:_user.mainImageURL];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSData *data = [NSData dataWithContentsOfURL:imageURL];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_pessoalPhoto setBackgroundImage:image forState:UIControlStateNormal];
                [_pessoalPhoto setTitle:@"" forState:UIControlStateNormal];
                _user.mainImage = image;
            });
        });
    } else {
        [_pessoalPhoto setBackgroundImage:_user.mainImage forState:UIControlStateNormal];
        [_pessoalPhoto setTitle:@"" forState:UIControlStateNormal];
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Animal *animal = [_listAnimals objectAtIndex:indexPath.row];
        [_listAnimals removeObjectAtIndex:indexPath.row];
        [animal deleteAnimal];
        [_tableView reloadData];

    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PessoalCellTableViewCell *cell = (PessoalCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.cellName.text = [(Animal *)_listAnimals[indexPath.row] nome];
    cell.animal = _listAnimals[indexPath.row];
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listAnimals.count;
}


-(void) refresh{
    _listAnimals = [Animal loadAnimalsFromUser];
    [_tableView reloadData];
    [_refreshControl endRefreshing];
}


-(void) loadData{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        _listAnimals = [Animal loadAnimalsFromUser];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
            if (_refreshControl != nil) {
                [_refreshControl endRefreshing];
            }
        });
    });
    
}

- (IBAction)profileDataChanged:(id)sender {
    _buttonSave.enabled = YES;
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

- (BOOL) formIsValid {
    if ([_pessoalName.text length] == 0 ||
        [_pessoalEmail.text length] == 0 ||
        [_pessoalPhone.text length] == 0)
    {
        UIAlertView *alertEmptyFields = [[UIAlertView alloc] initWithTitle:@"Campos em branco" message:@"Por favor, preencha todos os campos." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertEmptyFields show];
        return NO;
    }
    else if ([self validateEmail: _pessoalEmail.text] == NO){
        return NO;
    }
    else if([_pessoalPhone.text length] < 14 &&
            [_pessoalPhone.text length] > 15)
    {
        UIAlertView *alertPhoneInvalid = [[UIAlertView alloc] initWithTitle:@"Telefone inváido" message:@"Por favor, preencha um número válido de telefone." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertPhoneInvalid show];
        return NO;
    }
    NSLog(@"%@", _pessoalPhone.text);
    return YES;
}

- (void) saveProfileChanges{
    if([self formIsValid] == YES){
        _user.name = _pessoalName.text;
        _user.username = _pessoalEmail.text;
        _user.email = _pessoalEmail.text;
        _user.phone = _pessoalPhone.text;
        [_user updateData];
        
        UIAlertView *alertSaveSuccess = [[UIAlertView alloc] initWithTitle:@"Perfil salvo" message:@"As mudanças em seu perfil foram salvas com sucesso." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertSaveSuccess show];
        _buttonSave.enabled = NO;
    }
}

- (IBAction)saveClick:(id)sender {
    [self saveProfileChanges];
}

- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"LogoutSegue" sender:sender];
}

- (IBAction)clickViewBackground:(id)sender {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual: _pessoalName])
        [_pessoalEmail becomeFirstResponder];
    else if ([textField isEqual: _pessoalEmail])
        [_pessoalPhone becomeFirstResponder];
        
    return YES;
}
@end
