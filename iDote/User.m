//
//  User.m
//  iDote
//
//  Created by Eduardo Santi on 19/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "User.h"

@implementation User

- (void) cadastrar {
    _object = [[PFUser alloc] init];
    _object.username = _email;
    _object.password = _password;
    _object[@"Name"] = _name;
    [_object signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
        } else {
            //TODO: erro cadastro
        }
    }];
}

/*
 +(NSMutableArray *)loadInstitution{
 
 NSMutableArray *list = [[NSMutableArray alloc] init];
 PFQuery *query = [PFQuery queryWithClassName:@"Institution"];
 
 [query whereKey:@"ativo" equalTo:[NSNumber numberWithBool:true]];
 
 NSMutableArray *queryResult = [NSMutableArray arrayWithArray:[query findObjects]];
 
 for (PFObject *obj in queryResult) {
 Institution *inst = [[Institution alloc] init];
 inst.object = obj;
 inst.institutionName = [obj valueForKey:@"nome"];
 inst.institutionPhone = [obj valueForKey:@"telefone"];
 inst.institutionEmail = [obj valueForKey:@"email"];
 inst.institutionResponsible = [obj valueForKey:@"responsavel"];
 inst.institutionAddress = [obj valueForKey:@"endereco"];
 inst.institutionDescription = [obj valueForKey:@"descricao"];
 inst.ativo = [(NSNumber *)[obj valueForKey:@"ativo"] boolValue];
 
 [list addObject:inst];
 }
 
 return list;
 }*/

- (NSMutableArray *) login {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    
    [query whereKey:@"email" equalTo:_email];
    
    NSMutableArray *queryResult = [NSMutableArray arrayWithArray:[query findObjects]];
    
    for (PFObject *obj in queryResult) {
        User *usuario = [[User alloc] init];
        
        usuario.object = obj;
        usuario.name = [obj valueForKey:@"Name"];
        usuario.email = [obj valueForKey:@"email"];
        
    }

    
    return list;

}










@end
