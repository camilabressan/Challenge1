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
    _petName.text = _animal.nome;
    _petGender.text = _animal.genero;
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
