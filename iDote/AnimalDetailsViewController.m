//
//  AnimalDetailsViewController.m
//  iDote
//
//  Created by Adriano Soares on 27/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "AnimalDetailsViewController.h"

@interface AnimalDetailsViewController () <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *petImage;
@property (weak, nonatomic) IBOutlet UILabel *petName;
@property (weak, nonatomic) IBOutlet UILabel *petGender;
@property (weak, nonatomic) IBOutlet UILabel *petAge;
@property (weak, nonatomic) IBOutlet UILabel *petSize;
@property (weak, nonatomic) IBOutlet UITextView *petDescription;


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
    
    
}

- (IBAction)shareAnimal:(id)sender {
    NSURL *url = [[NSURL alloc] initWithString:_animal.mainImageURL];
    
    NSArray *itemsToShare = @[_animal.nome, url, _animal.descricao];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)call:(id)sender {
    NSString *str = [[_animal.dono.phone componentsSeparatedByCharactersInSet:
                            [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                           componentsJoinedByString:@""];
    NSString *phoneNumber = [@"tel:" stringByAppendingString:str];
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:phoneNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
        [[UIApplication sharedApplication] openURL:phoneURL];
    }else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"" message:@"Não é possível fazer a ligação" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}

- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if ([emailTest evaluateWithObject:candidate] == YES)
        return YES;
    else
    {
        UIAlertView *alertIncorrectEmail = [[UIAlertView alloc] initWithTitle:@"Email incorreto" message:@"Por favor, insira um e-mail válido." delegate: self cancelButtonTitle:@"OK"otherButtonTitles: nil];
        [alertIncorrectEmail show];
        return NO;
    }
}

- (IBAction)emailButtonPushed:(id)sender {
    
    if ([self validateEmail: _animal.dono.email] == YES){
        NSString *mail = _animal.dono.email;
        
        if([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
            mailCont.mailComposeDelegate = self;
            [mailCont setSubject:@""];
            [mailCont setToRecipients:[NSArray arrayWithObject:mail]];
            [mailCont setMessageBody:[NSString stringWithFormat:@"", ""]  isHTML:NO];
            [self presentViewController:mailCont animated:YES completion:nil];
            
        }
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    //handle any error
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}




@end
