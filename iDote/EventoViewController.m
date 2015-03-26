//
//  EventoViewController.m
//  iDote
//
//  Created by Camila Bressan Inácio on 25/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "EventoViewController.h"

@interface EventoViewController ()

@end

@implementation EventoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    Evento *criarEvento = [[Evento alloc] init];
    
    criarEvento.nomeEvento = _nomeEvento.text;
    criarEvento.endereco = _endereco.text;
    criarEvento.date = _data.date;
    criarEvento.descricao = _detalhes.text;
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