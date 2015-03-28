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
    
    _detailNameEvent.text = _event.nomeEvento;
    _detailAddress.text = _event.endereco;
    _detailDate.text = _event.date;
    _detailHour.text = _event.horario;
    _detailDescription.text = _event.descricao;

}


@end
