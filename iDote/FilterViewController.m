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
    Filter *filter = [[Filter alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"animalCity"] != nil)
        filter.animalCity = [userDefaults objectForKey:@"animalCity"];
    if ([userDefaults objectForKey:@"animalType"] != nil)
        filter.animalType = [userDefaults objectForKey:@"animalType"];
    if ([userDefaults objectForKey:@"animalGender"] != nil)
        filter.animalGender = [userDefaults objectForKey:@"animalGender"];
    if ([userDefaults objectForKey:@"animalSize"] != nil )
        filter.animalSize = [userDefaults objectForKey:@"animalSize"];
    
    self.formController.form = filter;
    
}

- (void) saveUserDefaultsFilters{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    Filter *filters = self.formController.form;
    NSLog(@"%@", [userDefaults objectForKey:@"animalCity"]);

    
    [userDefaults setObject: filters.animalCity
                     forKey:@"animalCity"];
    [userDefaults setObject: filters.animalGender
                     forKey:@"animalGender"];
    [userDefaults setObject: filters.animalSize
                     forKey:@"animalSize"];
    [userDefaults setObject: filters.animalType
                     forKey:@"animalType"];

    [userDefaults synchronize];

}

- (IBAction)clickButtonFilter:(id)sender {
    [self saveUserDefaultsFilters];
    [self performSegueWithIdentifier:@"ReturnFromFiltersSegue" sender:nil];
}

@end
