//
//  User.m
//  iDote
//
//  Created by Eduardo Santi on 19/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "User.h"


@implementation User

- (NSArray *)fields
{
    return @[@{FXFormFieldKey: @"mainImage",
               FXFormFieldTitle: @"Foto",
               FXFormFieldHeader: @"DADOS DO USUÁRIO",
               FXFormFieldType: FXFormFieldTypeImage},  
             @{FXFormFieldKey: @"name",
               FXFormFieldTitle: @"Nome"},
             @{FXFormFieldKey: @"email",
               FXFormFieldTitle: @"E-mail",
               FXFormFieldType: FXFormFieldTypeEmail},
             @{FXFormFieldKey: @"phone",
               FXFormFieldTitle: @"Telefone",
               FXFormFieldType: FXFormFieldTypePhone},
             @{FXFormFieldKey: @"password",
               FXFormFieldTitle: @"Senha",
               FXFormFieldType: FXFormFieldTypePassword},
             @{FXFormFieldKey: @"confirmPassword",
               FXFormFieldTitle: @"Confirmar senha",
               FXFormFieldType: FXFormFieldTypePassword},
         ];
}

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

-(void)save{
   // PFUser *user = [PFUser objectWithClassName:@"User"];
    PFUser *user;
    user = [PFUser user];
    //strings são as colunas da tabela do parse
    user.username = [_email lowercaseString];
    user.password = _password;
    user.email= [_email lowercaseString];
    user[@"Name"] = _name;
    user[@"phone"] = _phone;
    
    NSData *imageData = UIImageJPEGRepresentation(_mainImage, 0.7f);
    PFFile *imageFile = [PFFile fileWithName:@"Profileimage.png" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            if (succeeded) {
                user[@"mainPhoto"] = imageFile;
                [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (error) {
                        UIAlertView *alertSignUpError = [[UIAlertView alloc] initWithTitle:@"Sign up error" message:@"An unexpected error ocurred.\nPlease, check your internet connection or try a different username." delegate: self cancelButtonTitle:@"Dismiss"otherButtonTitles: nil];
                        [alertSignUpError show];
                        return;
                    }
                    
                    if (succeeded) {
                        _object = user;
                    }
                }];
                
            }
        }
    }];
    
    
    
}











@end
