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
    
    _addInstPic.image = image;
    
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
    
    //string that receives text that will go into the message body in email
    NSString *email = [NSString stringWithFormat:@"Nome: %@<br>Telefone: %@<br>Email: %@<br>Responsável: %@<br>Endereço: %@<br>Descrição: %@<br><br>", _txtFieldInstitutionName.text, _txtFieldInstitutionPhone.text, _txtFieldInstitutionEmail.text,_txtFieldInstitutionResponsible.text, _txtFieldInstitutionAddress.text, _txtViewInstitutionDescription.text];
    
    
    //compose email
     
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        
      //  NSString *file;
        NSData *pngData = UIImagePNGRepresentation(_addInstPic.image);
        NSString *picString = [pngData base64EncodedString];
        
        [mailCont setSubject:@"Cadastro de Instituição"];
       
        // Set up recipients
        NSArray *toRecipients = [NSArray arrayWithObject:@"idoteteam@gmail.com"];
        [mailCont setToRecipients:toRecipients];
    
        NSMutableString *htmlMsg = [NSMutableString string];
        [htmlMsg appendString:@"<html><body>"];
        [htmlMsg appendString:[NSString stringWithFormat: @"Verifique se o seu cadastro está correto antes de enviar!<br><br> %@ Aguarde até 48h úteis para receber um retorno da nossa equipe.<br>iDote Team agradece o seu interesse!", email]];
        
        [htmlMsg appendString:[NSString stringWithFormat:@"<img style='width:20%%, height:20%%;' src='data:image/png;base64,%@‘/></body></html>", picString]];
        
        /* //Determine the file name and extension
        NSArray *filepart = [file componentsSeparatedByString:@"."];
        NSString *filename = [filepart objectAtIndex:0];
        NSString *extension = [filepart objectAtIndex:1];
        
        // Get the resource path and read the file using NSData
        NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        
        // Determine the MIME type
        NSString *mimeType;
        if ([extension isEqualToString:@"jpg"]) {
            mimeType = @"image/jpeg";
        } else if ([extension isEqualToString:@"png"]) {
            mimeType = @"image/png";}
        
        // Add attachment
        [mailCont addAttachmentData:fileData mimeType:mimeType fileName:filename];*/
        
        [mailCont setMessageBody:htmlMsg isHTML:YES];
        
        

        //[mailCont setMessageBody:[NSString stringWithFormat: @"Verifique seu cadastro antes de enviar!\n\n %@\n\nAguarde até 48h úteis para receber um retorno da nossa equipe.\niDote Team agradece o seu interesse!", email]  isHTML:NO];
        
        
        [self presentViewController:mailCont animated:YES completion:nil];}
        
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
