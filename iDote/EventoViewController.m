//
//  EventoViewController.m
//  iDote
//
//  Created by Camila Bressan Inácio on 25/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "EventoViewController.h"

@interface EventoViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtFieldEventDate;
@property (weak, nonatomic) IBOutlet UITextView *txtViewDescription;

@end

@implementation EventoViewController{
    NSDateFormatter *dateFormat;
    UIDatePicker *datePicker;
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.txtFieldEventDate.inputView;
    self.txtFieldEventDate.text = [NSString stringWithFormat:@"%@",picker.date];
}

- (void)setBordersToDescriptiomTextView{
    CALayer *imageLayer = _txtViewDescription.layer;
    [imageLayer setCornerRadius:10];
    [imageLayer setBorderWidth:1];
    imageLayer.borderColor=[[UIColor lightGrayColor] CGColor];
}

- (void) createDatePicker{
    datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self
                action:@selector(updateTextField:)
                forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //dateFormat = [[NSDateFormatter alloc] init];
    //[dateFormat setDateFormat:@"'dd'/'MM'"];
    //[dateFormat setDateStyle:NSDateFormatterFullStyle];
    
    [self createDatePicker];
    [self.txtFieldEventDate setInputView:datePicker];
    
    [self setBordersToDescriptiomTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) emptyFieldDoesExist{
    if ([_nomeEvento.text  length] == 0 ||
        [_endereco.text length] == 0 ||
        [_txtFieldEventDate.text length] == 0 ||
        [_detalhes.text length] == 0)
    {
        UIAlertView *alertEmptyFields = [[UIAlertView alloc] initWithTitle:@"Campos incompletos" message:@"Por favor, preencha todos os campos." delegate: self cancelButtonTitle:@"OK"otherButtonTitles: nil];
        [alertEmptyFields show];
        return YES;
    }
    return NO;
}

- (void) createNewEvent{
    if([self emptyFieldDoesExist] == NO)
    {
        Evento *newEvent = [[Evento alloc] init];
        
        newEvent.nomeEvento = _nomeEvento.text;
        newEvent.endereco = _endereco.text;
        newEvent.date = datePicker.date;
        newEvent.descricao = _detalhes.text;
        
        [newEvent save];
        
        [self performSegueWithIdentifier:@"segueBackFromRegisterEvent" sender:nil];
    }
}

- (IBAction)save:(id)sender {
    [self createNewEvent];
}

- (IBAction)clickOnBackground:(id)sender {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:_nomeEvento])
        [_endereco becomeFirstResponder];
    else if ([textField isEqual: _endereco])
        [_txtFieldEventDate becomeFirstResponder];
    else if ([textField isEqual: _txtFieldEventDate])
        [_txtViewDescription becomeFirstResponder];
    else if ([textField isEqual:_txtViewDescription])
        [self createNewEvent];
    
    return YES;
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
