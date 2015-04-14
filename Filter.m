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
               FXFormFieldPlaceholder: @"Todos",
               FXFormFieldOptions: @[@"Cachorro", @"Gato", @"Outro"],
               FXFormFieldCell: [FXFormOptionSegmentsCell class]},
             @{FXFormFieldHeader: @"Gênero",
               FXFormFieldKey: @"animalGender",
               FXFormFieldTitle: @"",
               FXFormFieldPlaceholder: @"Todos",
               FXFormFieldOptions: @[@"Macho", @"Fêmea", @"Indefinido"],
               FXFormFieldCell: [FXFormOptionSegmentsCell class]},
             @{FXFormFieldHeader: @"Porte",
               FXFormFieldKey: @"animalSize",
               FXFormFieldTitle: @"",
               FXFormFieldPlaceholder: @"Todos",
               FXFormFieldOptions: @[@"Pequeno", @"Médio", @"Grande"],
               FXFormFieldCell: [FXFormOptionSegmentsCell class]}];
}

@end
