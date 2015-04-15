//
//  PessoalCellTableViewCell.h
//  iDote
//
//  Created by Eduardo Santi on 30/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animal.h"
#import "Evento.h"

@interface PessoalCellTableViewCell : UITableViewCell

@property Animal *animal;

@property (weak, nonatomic) IBOutlet UILabel *cellName;



@end
