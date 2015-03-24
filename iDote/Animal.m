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
               FXFormFieldPlaceholder: @"Cachorro",
               FXFormFieldOptions: @[@"Gato", @"Outro"],
               FXFormFieldCell: [FXFormOptionSegmentsCell class]},
             @{FXFormFieldHeader: @"Gênero",
               FXFormFieldKey: @"genero",
               FXFormFieldTitle: @"",
               FXFormFieldPlaceholder: @"Macho",
               FXFormFieldOptions: @[@"Fêmea", @"Indefinido"],
               FXFormFieldCell: [FXFormOptionSegmentsCell class]},
             @{FXFormFieldHeader: @"Porte",
               FXFormFieldKey: @"porte",
               FXFormFieldTitle: @"",
               FXFormFieldPlaceholder: @"Pequeno",
               FXFormFieldOptions: @[@"Médio", @"Grande"],
               FXFormFieldCell: [FXFormOptionSegmentsCell class]}];

}

@end

