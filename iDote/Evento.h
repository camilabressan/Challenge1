//
//  Evento.h
//  iDote
//
//  Created by Camila Bressan Inácio on 25/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "User.h"
#import "FXForms.h"

@interface Evento : NSObject <FXForm>

@property PFObject *object;
@property User *dono;

@property NSString *nomeEvento;
@property NSString *endereco;
@property NSDate *date;
@property NSString *horario;
@property NSString *descricao;

+ (NSMutableArray *) loadEvents;
+ (NSMutableArray *) loadEventsFromUser;

- (void) save;
- (void)deleteEvent;

@end
