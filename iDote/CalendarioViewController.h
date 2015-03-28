//
//  CalendarioViewController.h
//  iDote
//
//  Created by Camila Bressan Inácio on 23/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "eventTableViewCell.h"
#import "Evento.h"
#import "DetailEventViewController.h"

@interface CalendarioViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *TabelaCalendario;
@property(nonatomic, retain) UIColor *tintColor;


@end
