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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FXFormViewController *controller = [[FXFormViewController alloc] init];
    controller.formController.form = [[Animal alloc] init];
    
    _navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
    controller.navigationItem.title = @"Dados do Animal";
    controller.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Salvar" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    
    [self presentViewController:_navController animated:NO completion:nil];
    
    
    self.checkGenero; //inicializa visualmente o genero do animal
    self.checkPorte; //inicializa visualmente o porte do animal
    self.changeAge; //inicializa visualmente a idade do animal
    
}

- (void)dismiss:(id)sender {
    
}

- (void)save:(id)sender {
    
    [_navController dismissViewControllerAnimated:YES completion:^{
        FXFormViewController *formQueVoltou = (FXFormViewController*)_navController.topViewController;
        _animal = formQueVoltou.formController.form;
    }];
    [self performSegueWithIdentifier:@"segueBackFromRegisterAnimal" sender:sender];
    

}

- (IBAction)saveClick:(id)sender {
    [_navController dismissViewControllerAnimated:YES completion:^{
        FXFormViewController *formQueVoltou = (FXFormViewController*)_navController.topViewController;
        _animal = formQueVoltou.formController.form;
        NSLog(@"%@", _animal.nome);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) checkGenero {
    Animal *animalTESTE = [[Animal alloc] init];
    
    if (_segmentedGenero.selectedSegmentIndex == 0) {
        _animal.genero = @"femea";
//        NSLog(@"%@", animal.genero);
    }
    if (_segmentedGenero.selectedSegmentIndex == 1) {
        _animal.genero = @"macho";
//        NSLog(@"%@", animal.genero);
    }
}

- (IBAction)checkPorte {
    Animal *animal = [[Animal alloc] init];
    
    if (_segmentedPorte.selectedSegmentIndex == 0) {
        animal.porte = @"pequeno";
        NSLog(@"%@", animal.porte);
    }
    if (_segmentedPorte.selectedSegmentIndex == 1) {
        animal.porte = @"medio";
        NSLog(@"%@", animal.porte);
    }
    if (_segmentedPorte.selectedSegmentIndex == 2) {
        animal.porte = @"grande";
        NSLog(@"%@", animal.porte);
    }
}

- (IBAction)changeAge {
    Animal *animal = [[Animal alloc] init];
    NSInteger idade = _slider.value;
    
    switch (idade) {
        case 1:
            _labelIdade.text = @"Idade: 0 a 1 Ano";
            animal.idade = idade;
            break;
            
        case 2:
            _labelIdade.text = @"Idade: 1 a 3 Anos";
            animal.idade = idade;
            break;
            
        case 3:
            _labelIdade.text = @"Idade: 3 a 6 Anos";
            animal.idade = idade;
            break;
            
        case 4:
            _labelIdade.text = @"Idade: 6 anos ou mais";
            animal.idade = idade;
            break;
    }
}

- (IBAction)clickBackground:(id)sender {
    [self.view endEditing:YES];
}

@end