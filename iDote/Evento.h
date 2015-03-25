//
//  Evento.h
//  iDote
//
//  Created by Camila Bressan Inácio on 25/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Evento : NSObject

@property PFObject *object;

@property NSString *nomeEvento;
@property NSString *endereco;
@property NSDate *date;
@property NSString *horario;
@property NSString *descricao;

- (void) save;

@end
