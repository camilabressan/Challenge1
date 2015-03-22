//
//  CadastroAnimalViewController.m
//  iDote
//
//  Created by Eduardo Santi on 21/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "CadastroAnimalViewController.h"

@interface CadastroAnimalViewController ()

@end

@implementation CadastroAnimalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.checkGenero; //inicializa visualmente o genero do animal
    self.checkPorte; //inicializa visualmente o porte do animal
    self.changeAge; //inicializa visualmente a idade do animal
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) checkGenero {
    Animal *animal = [[Animal alloc] init];
    
    if (_segmentedGenero.selectedSegmentIndex == 0) {
        animal.genero = @"femea";
        NSLog(@"%@", animal.genero);
    }
    if (_segmentedGenero.selectedSegmentIndex == 1) {
        animal.genero = @"macho";
        NSLog(@"%@", animal.genero);
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





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
