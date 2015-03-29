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

+ (NSMutableArray *)loadEvents {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    
    NSMutableArray *queryResult = [NSMutableArray arrayWithArray:[query findObjects]];
    
    for (PFObject *obj in queryResult) {
        Evento *event = [[Evento alloc] init];
        event.object = obj;
        
        event.nomeEvento = [obj valueForKey:@"nome"];
        event.endereco = [obj valueForKey:@"endereco"];
        event.date = [obj valueForKey: @"date"];
        event.descricao = [obj valueForKey:@"descricao"];
        
        
        [list addObject:event];
    }
    
    return list;
}

@end
