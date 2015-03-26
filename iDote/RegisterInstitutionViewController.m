//
//  RegisterInstitutionViewController.m
//  iDote
//
//  Created by Tainara Specht on 3/23/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "RegisterInstitutionViewController.h"
@interface RegisterInstitutionViewController() <MFMailComposeViewControllerDelegate>

@end

@implementation RegisterInstitutionViewController

Institution *institution;

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [_addInstPic setBackgroundImage:image forState:UIControlStateNormal];
    [_addInstPic setTitle:@"" forState:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)setFirstImage:(id)sender {
    
    UIImagePickerController *imagePickerControllerMain = [[UIImagePickerController alloc] init];
    imagePickerControllerMain.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerControllerMain.delegate = self;
    
    [self presentViewController:imagePickerControllerMain animated:NO completion:nil];
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

-(BOOL) emptyTextFieldExistent
{
    if ([_txtFieldInstitutionName.text length] == 0 ||
        [_txtFieldInstitutionPhone.text length] == 0 ||
        [_txtFieldInstitutionEmail.text length] == 0 ||
        [_txtFieldInstitutionResponsible.text length] == 0 ||
        [_txtFieldInstitutionAddress.text length] == 0 ||
        [_txtViewInstitutionDescription.text length] == 0)
    {
        UIAlertView *alertEmptyFields = [[UIAlertView alloc] initWithTitle:@"Campos incompletos" message:@"Por favor, preencha todos os campos." delegate: self cancelButtonTitle:@"OK"otherButtonTitles: nil];
        [alertEmptyFields show];
        return YES;
    }
    return NO;
}


- (void) cadastrarInst {
    
     institution = [[Institution alloc] init];

    
    institution.institutionName = _txtFieldInstitutionName.text;
    institution.institutionPhone = _txtFieldInstitutionPhone.text;
    institution.institutionEmail = _txtFieldInstitutionEmail.text;
    institution.institutionResponsible = _txtFieldInstitutionResponsible.text;
    institution.institutionAddress = _txtFieldInstitutionAddress.text;
    institution.institutionDescription = _txtViewInstitutionDescription.text;
    
}

- (IBAction)emailButtonPushed:(id)sender {
    
    if ([self validateEmail: _txtFieldInstitutionEmail.text] == YES &&
        [self emptyTextFieldExistent] == NO){
    
    NSString *email = [NSString stringWithFormat:@"Nome: %@\nTelefone: %@\nEmail: %@\nResponsável: %@\nEndereço: %@\nDescrição: %@", _txtFieldInstitutionName.text, _txtFieldInstitutionPhone.text, _txtFieldInstitutionEmail.text,_txtFieldInstitutionResponsible.text, _txtFieldInstitutionAddress.text, _txtViewInstitutionDescription.text];

    NSLog(@"%@", email);
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        [mailCont setSubject:@"Cadastro de Instituições"];
        [mailCont setToRecipients:[NSArray arrayWithObject:@"idoteteam@gmail.com"]];
    
       
        [mailCont setMessageBody:[NSString stringWithFormat:@"Verifique seu cadastro antes de enviar!\n\n %@", email]  isHTML:NO];
        [self presentViewController:mailCont animated:YES completion:nil];
        
        
        UIImage *institutionImage = [UIImage imageNamed:@"anImage"];
        NSData *myData = UIImageJPEGRepresentation(institutionImage, 1.0);
        
        
        [mailCont addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"anImage.jpg"];
        
        //DESCOBRIR COMO IMPORTAR A DANADA DA IMAGEM!
       
     /*   // Determine the file name and extension
        NSArray *filepart = [email componentsSeparatedByString:@"."];
        NSString *filename = [filepart objectAtIndex:0];
        NSString *extension = [filepart objectAtIndex:1];
        
        // Get the resource path and read the file using NSData
     //   NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
        //NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        
        Determine the MIME type
        NSString *mimeType;
        if ([extension isEqualToString:@"jpg"]) {
            mimeType = @"image/jpeg";
        } else if ([extension isEqualToString:@"png"]) {
            mimeType = @"image/png";}
        
        // Add attachment
        [mailCont addAttachmentData:myData mimeType:mimeType fileName:filename];
        
        // Present mail view controller on screen
        [self presentViewController:mailCont animated:YES completion:NULL];*/
    
    
    
    }
        
        
    }

}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    //handle any error
    [controller dismissViewControllerAnimated:YES completion:nil];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end