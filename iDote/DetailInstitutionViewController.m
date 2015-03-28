//
//  DetailInstitutionViewController.m
//  iDote
//
//  Created by Eduardo Santi on 25/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "DetailInstitutionViewController.h"

@interface DetailInstitutionViewController ()

@end

@implementation DetailInstitutionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _nameDetail.text = _inst.institutionName;
    _phoneDetail.text = _inst.institutionPhone;
    _emailDetail.text = _inst.institutionEmail;
    _responsibleDetail.text = _inst.institutionResponsible;
    _addressDetail.text = _inst.institutionAddress;
    _descriptionDetail.text = _inst.institutionDescription;
    _descriptionDetail.editable = NO;
    
    
}



@end
