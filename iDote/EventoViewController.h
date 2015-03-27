//
//  EventoViewController.h
//  iDote
//
//  Created by Camila Bressan Inácio on 25/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>
 #import <QuartzCore/QuartzCore.h>
#import "Evento.h"
#import "Institution.h"

@interface EventoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nomeEvento;
@property (weak, nonatomic) IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextView *detalhes;
@property PFObject *event;



@end
