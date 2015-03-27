//
//  Evento.m
//  iDote
//
//  Created by Camila Bressan Inácio on 25/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "Evento.h"

@implementation Evento

- (void)save {
    PFObject *object = [PFObject objectWithClassName:@"Event"];
    object[@"nome"] = _nomeEvento;
    object[@"endereco"] = _endereco;
    object[@"descricao"] = _descricao;
    object[@"date"] = _date;
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            _object = object;
            PFRelation *relation = [object relationForKey:@"user"];
            [relation addObject:[PFUser currentUser]];
            [object saveInBackground];
        }
    }];
}

@end
