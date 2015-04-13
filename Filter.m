//
//  Filter.m
//  iDote
//
//  Created by Jonathan Andrade on 13/04/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "Filter.h"

@implementation Filter

- (NSArray *)fields
{
    return @[@{FXFormFieldKey: @"animalCity",
               FXFormFieldTitle: @"Cidade",
               FXFormFieldHeader: @"FILTROS"},
             @{FXFormFieldHeader: @"Tipo",
               FXFormFieldKey: @"animalType",
               FXFormFieldTitle: @"",
               FXFormFieldOptions: @[@"Cachorro", @"Gato", @"Outro"],
               FXFormFieldCell: [FXFormOptionSegmentsCell class]},
             @{FXFormFieldHeader: @"Gênero",
               FXFormFieldKey: @"animalGender",
               FXFormFieldTitle: @"",
               FXFormFieldOptions: @[@"Macho", @"Fêmea", @"Indefinido"],
               FXFormFieldCell: [FXFormOptionSegmentsCell class]},
             @{FXFormFieldHeader: @"Porte",
               FXFormFieldKey: @"animalSize",
               FXFormFieldTitle: @"",
               FXFormFieldOptions: @[@"Pequeno", @"Médio", @"Grande"],
               FXFormFieldCell: [FXFormOptionSegmentsCell class]}];
}

@end
