//
//  RegisterAnimalPhotoController.m
//  iDote
//
//  Created by Jonathan Andrade on 23/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "RegisterAnimalPhotoController.h"
#import "UIImage+Resize.h"

@interface RegisterAnimalPhotoController ()

@property UIButton *imageHolder;

@end

@implementation RegisterAnimalPhotoController{
    UINavigationController *_navController;
    Animal *_animal;
}

- (IBAction)backFromRegisterAnimal:(UIStoryboardSegue *)segue {
    
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [UIImage cropImageWithInfo:info];
    [_imageHolder setBackgroundImage:image forState:UIControlStateNormal];
    [_imageHolder setTitle:@"" forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)setFirstImage:(UIButton *)sender {
    _imageHolder = sender;
    UIImagePickerController *imagePickerControllerMain = [[UIImagePickerController alloc] init];
    imagePickerControllerMain.allowsEditing = YES;
    
    imagePickerControllerMain.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerControllerMain.delegate = self;
    [self presentViewController:imagePickerControllerMain animated:NO completion:nil];
}

- (BOOL) mainPhotoDoesExist
{
    if ([_mainImage backgroundImageForState:UIControlStateNormal] == nil)
         return NO;
    else
        return YES;
}

- (IBAction)clickButtonNext:(id)sender {    
    
    if ([self mainPhotoDoesExist] == YES)
    {
        FXFormViewController *controller = [[FXFormViewController alloc] init];
        controller.formController.form = [[Animal alloc] init];
        
        _navController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
        controller.navigationItem.title = @"Dados do Animal";
        controller.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Salvar" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
        
        [self presentViewController:_navController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertPhotoDoesnExist = [[UIAlertView alloc] initWithTitle:@"Selecione uma foto" message:@"Por favor, selecione uma foto do animal" delegate: self cancelButtonTitle:@"OK"otherButtonTitles: nil];
        [alertPhotoDoesnExist show];
    }
}

- (void)dismiss:(id)sender {
    [_navController dismissViewControllerAnimated:YES completion:^{
    }];
}

-(BOOL) emptyTextFieldExistent
{
    if ( _animal.nome == nil ||
        _animal.descricao == nil ||
        _animal.tipo == nil ||
        _animal.genero == nil ||
        _animal.porte == nil ||
        _animal.cidade == nil
        )
    {
        UIAlertView *alertEmptyFields = [[UIAlertView alloc] initWithTitle:@"Campos incompletos" message:@"Por favor, preencha todos os campos." delegate: self cancelButtonTitle:@"OK"otherButtonTitles: nil];
        [alertEmptyFields show];
        return YES;
    }
    else
        return NO;
}

- (void)save:(id)sender {
    FXFormViewController *formQueVoltou = (FXFormViewController*)_navController.topViewController;
    _animal = formQueVoltou.formController.form;
    
    if ([self emptyTextFieldExistent] == NO){
        [_navController dismissViewControllerAnimated:NO completion:^{
            [self performSegueWithIdentifier:@"segueReturnFromRegisterAnimal" sender:sender];
            UIAlertView *alertAnimalInserted = [[UIAlertView alloc] initWithTitle:@"Novo animal" message:@"Animal inserido com sucesso!" delegate: self cancelButtonTitle:@"OK"otherButtonTitles: nil];
            [alertAnimalInserted show];
        }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueReturnFromRegisterAnimal"] && _animal != nil) {
        _animal.mainImage = [_mainImage backgroundImageForState:UIControlStateNormal];
        [_animal save];
    }


}

@end
