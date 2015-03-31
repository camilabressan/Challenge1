//
//  Institution.m
//  iDote
//
//  Created by Tainara Specht on 3/22/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "Institution.h"

@implementation Institution

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
}

- (NSArray *)fields
{
    return @[@{FXFormFieldKey: @"mainImage",
               FXFormFieldTitle: @"Imagem",
               FXFormFieldHeader: @"DADOS",
               FXFormFieldType: FXFormFieldTypeImage},
             @{FXFormFieldKey: @"institutionName",
               FXFormFieldTitle: @"Nome da Instituição"},
             @{FXFormFieldKey: @"institutionResponsible",
               FXFormFieldTitle: @"Responsável"},
             @{FXFormFieldKey: @"institutionPhone",
               FXFormFieldTitle: @"Telefone",
               FXFormFieldType: FXFormFieldTypePhone},
             @{FXFormFieldKey: @"institutionEmail",
               FXFormFieldTitle: @"E-mail",
               FXFormFieldType: FXFormFieldTypeEmail},
             @{FXFormFieldKey: @"institutionAddress",
               FXFormFieldTitle: @"Endereço",
               FXFormFieldPlaceholder: @"endereço opcional"},
             @{FXFormFieldTitle: @"Descrição",
               FXFormFieldKey: @"institutionDescription",
               FXFormFieldType: FXFormFieldTypeLongText,
               FXFormFieldPlaceholder: @"Insira aqui descrições gerais da instituição..."}];
}

-(void)save{
    PFObject *object = [PFObject objectWithClassName:@"Institution"];
    //strings são as colunas da tabela do parse
    object[@"nome"] = _institutionName;
    object[@"telefone"] = _institutionPhone;
    object[@"email"] = _institutionEmail;
    if (_institutionAddress != nil) // campo não obrigatório
        object[@"endereco"] = _institutionAddress;
    object[@"descricao"] = _institutionDescription;
    object[@"responsavel"] = _institutionResponsible;
    object[@"ativo"] = [NSNumber numberWithBool:false]; //sempre será inserido falso porque dependerá de aprovação
    
    NSData *imageData = UIImageJPEGRepresentation(_mainImage, 0.7f);
    PFFile *imageFile = [PFFile fileWithName:@"Profileimage.png" data:imageData];
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if(!error){
            if (succeeded){
                object[@"foto"] = imageFile;
                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        _object = object;
                        /*
                        PFRelation *relation = [object relationForKey:@"responsavel"];
                        [relation addObject:[PFUser currentUser]];
                        [object saveInBackground];
                        */
                    }
                }];
                
            }
        }
    }];
    
   
    
}

@end
