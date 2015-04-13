//
//  FilterViewController.m
//  iDote
//
//  Created by Jonathan Andrade on 13/04/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "FilterViewController.h"
#import "Filter.h"

@implementation FilterViewController

- (void)awakeFromNib{
    self.formController.form = [[Filter alloc] init];
    
}

- (void) saveUserDefaultsFilters{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Filter *filters = self.formController.form;
    
    [userDefaults setObject: filters.animalCity
                     forKey:@"animalCity"];

    [userDefaults synchronize];}

- (IBAction)clickButtonFilter:(id)sender {
    [self saveUserDefaultsFilters];
}

@end
