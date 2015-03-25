//
//  RegisterAnimalDataController.m
//  iDote
//
//  Created by Jonathan Andrade on 23/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "RegisterAnimalDataController.h"

@interface RegisterAnimalDataController ()

@end

@implementation RegisterAnimalDataController {
    UINavigationController *_navController;
    Animal *_animal;
}

- (IBAction)backFromRegisterAnimalData:(UIStoryboardSegue *)segue {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FXFormViewController *controller = [[FXFormViewController alloc] init];
    controller.formController.form = [[Animal alloc] init];
    
    _navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
    controller.navigationItem.title = @"Dados do Animal";
    controller.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Salvar" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    
    [self presentViewController:_navController animated:NO completion:nil];
    
    
}

- (void)dismiss:(id)sender {
    
}

- (void)save:(id)sender {
    
    [_navController dismissViewControllerAnimated:YES completion:^{
        FXFormViewController *formQueVoltou = (FXFormViewController*)_navController.topViewController;
        _animal = formQueVoltou.formController.form;
        [_animal save];
    }];
    
    
    //[self performSegueWithIdentifier:@"segueBackFromRegisterAnimal" sender:sender];
    

}

- (IBAction)saveClick:(id)sender {
    /*[_navController dismissViewControllerAnimated:YES completion:^{
        FXFormViewController *formQueVoltou = (FXFormViewController*)_navController.topViewController;
        _animal = formQueVoltou.formController.form;
        NSLog(@"%@", _animal.nome);
    }];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickBackground:(id)sender {
    [self.view endEditing:YES];
}

@end