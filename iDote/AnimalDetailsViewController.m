//
//  AnimalDetailsViewController.m
//  iDote
//
//  Created by Adriano Soares on 27/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "AnimalDetailsViewController.h"

@interface AnimalDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *petImage;
@property (weak, nonatomic) IBOutlet UILabel *petName;
@property (weak, nonatomic) IBOutlet UILabel *petGender;
@property (weak, nonatomic) IBOutlet UILabel *petAge;
@property (weak, nonatomic) IBOutlet UILabel *petSize;
@property (weak, nonatomic) IBOutlet UILabel *petDescription;

@property (weak, nonatomic) IBOutlet UIImageView *ownerImage;
@property (weak, nonatomic) IBOutlet UILabel *ownerName;
@property (weak, nonatomic) IBOutlet UILabel *ownerEmail;
@property (weak, nonatomic) IBOutlet UILabel *ownerPhone;

@end

@implementation AnimalDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_animal.mainImage == nil) {
        NSURL *imageURL = [[NSURL alloc] initWithString:_animal.mainImageURL];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSData *data = [NSData dataWithContentsOfURL:imageURL];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                _petImage.image = image;
                _animal.mainImage = image;
            });
        });
    } else {
        _petImage.image = _animal.mainImage;
    }
    
    if (_animal.dono.mainImage == nil) {
        NSURL *imageURL = [[NSURL alloc] initWithString:_animal.dono.mainImageURL];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSData *data = [NSData dataWithContentsOfURL:imageURL];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                _animal.dono.mainImage = image;
                _ownerImage.image = image;
            });
        });
    } else {
        _ownerImage.image = _animal.dono.mainImage;
    }
    
    _petName.text = _animal.nome;
    _petGender.text = _animal.genero;
    _petSize.text = _animal.porte;
    _petDescription.text = _animal.descricao;
    
    NSString *ageRange;
    if ( _animal.idade <= 3) {
        ageRange = @"0 - 3 anos";
    } else if (_animal.idade <= 7) {
        ageRange = @"4 - 7 anos";
    } else {
        ageRange = @"8 ou mais anos";
    }
    
    _petAge.text = ageRange;
    
    _ownerName.text = _animal.dono.name;
    _ownerEmail.text = _animal.dono.email;
    _ownerPhone.text = _animal.dono.phone;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
