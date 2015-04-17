//
//  DetailInstitutionViewController.m
//  iDote
//
//  Created by Eduardo Santi on 25/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "DetailInstitutionViewController.h"

@interface DetailInstitutionViewController () <MFMailComposeViewControllerDelegate>

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
    
    if (_inst.mainImage == nil) {
        PFFile *photo = [_inst.object valueForKey:@"foto"];
        NSURL *imageURL = [[NSURL alloc] initWithString:[photo url]];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSData *data = [NSData dataWithContentsOfURL:imageURL];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_photoDetail setBackgroundImage:image forState:UIControlStateNormal];
                _inst.mainImage = image;
            });
        });
    } else {
       [_photoDetail setBackgroundImage:_inst.mainImage forState:UIControlStateNormal];
    }
    
    [self setConfigImage];
}

-(void) setConfigImage{
    _photoDetail.layer.borderWidth = 2;
    _photoDetail.layer.borderColor = [[UIColor orangeColor]CGColor];
    _photoDetail.layer.cornerRadius = _photoDetail.frame.size.height/2;
    _photoDetail.layer.masksToBounds = YES;
}

- (IBAction)call:(id)sender {
    NSString *str = [[_inst.institutionPhone componentsSeparatedByCharactersInSet:
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
    
    if ([self validateEmail: _inst.institutionEmail] == YES){
        NSString *mail = _inst.institutionEmail;
        
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
