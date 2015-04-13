//
//  Filter.h
//  iDote
//
//  Created by Jonathan Andrade on 13/04/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXForms.h"

@interface Filter : NSObject <FXForm>

@property (nonatomic, copy) NSString *animalType;
@property (nonatomic, copy) NSString *animalSize;
@property (nonatomic, copy) NSString *animalGender;
@property (nonatomic, copy) NSString *animalCity;

@end
