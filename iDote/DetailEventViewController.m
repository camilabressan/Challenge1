//
//  DetailEventViewController.m
//  iDote
//
//  Created by Eduardo Santi on 27/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "DetailEventViewController.h"

@interface DetailEventViewController ()

@end

@implementation DetailEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _detailNameEvent.text = _ev.nomeEvento;
    _detailAddress.text = _ev.endereco;
    _detailDate.text = _ev.date;
    _detailHour.text = _ev.horario;
    _detailDescription.text = _ev.descricao;

}


@end
