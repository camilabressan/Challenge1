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

@end

