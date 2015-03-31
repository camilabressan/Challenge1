//
//  User.m
//  iDote
//
//  Created by Eduardo Santi on 19/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "User.h"


@implementation User

+ (User *)loadCurrentUser {
    if ([PFUser currentUser] != nil) {
        User *user = [[User alloc] init];
        user.object = [PFUser currentUser];
        
        user.name = user.object[@"Name"];
        user.email = user.object[@"email"];
        user.username = user.object[@"username"];
        user.password = user.object[@"password"];
        user.phone = user.object[@"phone"];
        user.mainImageURL = [(PFFile *)user.object[@"mainPhoto"] url];
        
        return user;
    }
    return nil;
}

+ (User *)loadUserFromObject:(PFObject *)object {
    if (object != nil) {
        User *user = [[User alloc] init];

        user = [User loadCurrentUser];
        
        PFRelation *relation = [object relationForKey:@"user"];
        PFQuery *query = [relation query];
        
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                user.object = (PFUser *)object;
                user.name = user.object[@"Name"];
                user.email = user.object[@"email"];
                user.username = user.object[@"username"];
                user.password = user.object[@"password"];
                user.phone = user.object[@"phone"];
                user.mainImageURL = [(PFFile *)user.object[@"mainPhoto"] url];
            }
        }];
        return user;
    }
    return nil;
}

- (void) updateData {
    _object.username = _email;
    _object.email = _email;
    _object[@"Name"] = _name;
    _object[@"phone"] = _phone;
    [_object saveInBackground];
}

- (void) cadastrar {
    _object = [[PFUser alloc] init];
    _object.username = _email;
    _object.email = _email;
    _object.password = _password;
    _object[@"Name"] = _name;
    _object[@"phone"] = _phone;
    
    [_object signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro ao Cadastrar" message:@"Não foi possível cadastrar seus dados" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alert show];
        }
    }];
}

- (void) login {
    

}










@end
