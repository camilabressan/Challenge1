//
//  InstitutionTableViewCell.h
//  iDote
//
//  Created by Eduardo Santi on 25/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Institution.h"

@interface InstitutionTableViewCell : UITableViewCell

@property Institution *institution;

@property (weak, nonatomic) IBOutlet UIImageView *imageInstitution;
@property (weak, nonatomic) IBOutlet UILabel *nameInstitution;
@property (weak, nonatomic) IBOutlet UILabel *phoneInstitution;


@end
