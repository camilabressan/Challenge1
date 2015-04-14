//
//  Animal.m
//  iDote
//
//  Created by Eduardo Santi on 20/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "Animal.h"

@implementation Animal

- (NSArray *)fields
{
    return @[@{FXFormFieldKey: @"nome", FXFormFieldHeader: @"DADOS"},
             @{FXFormFieldKey: @"idade", FXFormFieldCell: [FXFormStepperCell class]},
             @{FXFormFieldKey: @"cidade"},
             @{FXFormFieldTitle: @"Descrição",
               FXFormFieldKey: @"descricao",
               FXFormFieldType: FXFormFieldTypeLongText,
               FXFormFieldPlaceholder: @"Insira aqui descrições gerais do animal..."},
             @{FXFormFieldHeader: @"Tipo",
               FXFormFieldKey: @"tipo",
               FXFormFieldTitle: @"",
               FXFormFieldOptions: @[@"Cachorro", @"Gato", @"Outro"],
               FXFormFieldCell: [FXFormOptionSegmentsCell class]},
             @{FXFormFieldHeader: @"Gênero",
               FXFormFieldKey: @"genero",
               FXFormFieldTitle: @"",
               FXFormFieldOptions: @[@"Macho", @"Fêmea", @"Indefinido"],
               FXFormFieldCell: [FXFormOptionSegmentsCell class]},
             @{FXFormFieldHeader: @"Porte",
               FXFormFieldKey: @"porte",
               FXFormFieldTitle: @"",
               FXFormFieldOptions: @[@"Pequeno", @"Médio", @"Grande"],
               FXFormFieldCell: [FXFormOptionSegmentsCell class]}];
}



+ (NSMutableArray *)loadAnimals {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Animal"];
    query.limit = 3;
    [query orderByAscending:@"createdAt"];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults objectForKey:@"animalCity"] != nil &&
        ![[userDefaults objectForKey:@"animalCity"] isEqualToString: @""]) {
        [query whereKey:@"city" equalTo:[userDefaults objectForKey:@"animalCity"]];
    
    }
    
    if ([userDefaults objectForKey:@"animalGender"] != nil &&
        ![[userDefaults objectForKey:@"animalGender"] isEqualToString:@"Todos"] ) {
        [query whereKey:@"gender" equalTo:[userDefaults objectForKey:@"animalGender"]];
        
    }
    
    if ([userDefaults objectForKey:@"animalSize"] != nil &&
        ![[userDefaults objectForKey:@"animalSize"] isEqualToString:@"Todos"] ) {
        [query whereKey:@"gender" equalTo:[userDefaults objectForKey:@"animalSize"]];
        
    }
    if ([userDefaults objectForKey:@"animalType"] != nil &&
        ![[userDefaults objectForKey:@"animalType"] isEqualToString:@"Todos"] ) {
        [query whereKey:@"type" equalTo:[userDefaults objectForKey:@"animalType"]];
        
    }


    NSMutableArray *queryResult = [NSMutableArray arrayWithArray:[query findObjects]];
    
    for (PFObject *obj in queryResult) {
        Animal *animal = [[Animal alloc] init];
        animal.object = obj;
        animal.dono = [User loadUserFromObject:obj];
        
        animal.nome = [obj objectForKey:@"name"];
        animal.mainImageURL = [(PFFile *)[obj objectForKey:@"mainPhoto"] url];
        
        animal.genero = [obj objectForKey:@"gender"];
        animal.idade =  [(NSNumber *)[obj objectForKey:@"age"] intValue];
        animal.tipo = [obj objectForKey:@"type"];
        animal.porte = [obj objectForKey:@"size"];
        animal.descricao = [obj objectForKey:@"description"];
        animal.cidade = [obj objectForKey:@"city"];
        
        [list addObject:animal];
    }

    return list;
}

+ (NSMutableArray *)loadNewAnimals:(Animal *)animal {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Animal"];
    query.limit = 1;
    [query orderByAscending:@"createdAt"];
    
    [query whereKey:@"createdAt" greaterThan:animal.object.createdAt];
    
    NSMutableArray *queryResult = [NSMutableArray arrayWithArray:[query findObjects]];
    
    for (PFObject *obj in queryResult) {
        Animal *animal = [[Animal alloc] init];
        animal.object = obj;
        animal.dono = [User loadUserFromObject:obj];
        
        animal.nome = [obj objectForKey:@"name"];
        animal.mainImageURL = [(PFFile *)[obj objectForKey:@"mainPhoto"] url];
        
        animal.genero = [obj objectForKey:@"gender"];
        animal.idade =  [(NSNumber *)[obj objectForKey:@"age"] intValue];
        animal.tipo = [obj objectForKey:@"type"];
        animal.porte = [obj objectForKey:@"size"];
        animal.descricao = [obj objectForKey:@"description"];
        animal.cidade = [obj objectForKey:@"city"];
        
        [list addObject:animal];
    }
    
    return list;
}


+ (NSMutableArray *)loadAnimalsFromUser {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Animal"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    
    NSMutableArray *queryResult = [NSMutableArray arrayWithArray:[query findObjects]];
    
    for (PFObject *obj in queryResult) {
        Animal *animal = [[Animal alloc] init];
        animal.object = obj;
        animal.dono = [User loadUserFromObject:obj];
        
        animal.nome = [obj objectForKey:@"name"];
        animal.mainImageURL = [(PFFile *)[obj objectForKey:@"mainPhoto"] url];
        
        animal.genero = [obj objectForKey:@"gender"];
        animal.idade =  [(NSNumber *)[obj objectForKey:@"age"] intValue];
        animal.tipo = [obj objectForKey:@"type"];
        animal.porte = [obj objectForKey:@"size"];
        animal.descricao = [obj objectForKey:@"description"];
        animal.cidade = [obj objectForKey:@"city"];
        
        [list addObject:animal];
    }
    
    return list;
}

-(void)save {
    PFObject *object = [PFObject objectWithClassName:@"Animal"];
    
    object[@"name"] = _nome;
    object[@"gender"] = _genero;
    object[@"age"] = [NSNumber numberWithInt:(int)_idade];
    object[@"type"] = _tipo;
    object[@"size"] = _porte;
    object[@"description"] = _descricao;
    object[@"city"] = _cidade;
    
    NSData *imageData = UIImageJPEGRepresentation(_mainImage, 0.7f);
    PFFile *imageFile = [PFFile fileWithName:@"Profileimage.png" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            if (succeeded) {
                object[@"mainPhoto"] = imageFile;
                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        _object = object;
                        PFRelation *relation = [object relationForKey:@"user"];
                        [relation addObject:[PFUser currentUser]];
                        [object saveInBackground];
                    }
                }];
            }
        } else {
            // Handle error
        }        
    }];


}

- (void)deleteAnimal {
    [_object deleteInBackground];
}
@end

