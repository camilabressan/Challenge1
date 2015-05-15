//
//  RegisterAnimalViewController.m
//  iDote
//
//  Created by Jonathan Andrade on 15/04/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "RegisterAnimalViewController.h"

@interface RegisterAnimalViewController ()

@property UIButton *imageHolder;

@end

@implementation RegisterAnimalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        [self.locationManager requestWhenInUseAuthorization];
        //[self.locationManager requestAlwaysAuthorization];
    }
#endif
    [self.locationManager startUpdatingLocation];
    
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}
- (IBAction)saveClickButton:(id)sender {
    if ([self emptyFieldsExist] == NO &&
        [self mainPhotoDoesExist] == YES)
    {
        Animal *animal = [[Animal alloc] init];
        animal.mainImage = [_mainImage backgroundImageForState:UIControlStateNormal];
        animal.nome = _nameTextFielld.text;
        animal.cidade = _cityTextField.text;
        animal.descricao = _descriptionTextView.text;
        animal.tipo = [_typeSegControl titleForSegmentAtIndex:_typeSegControl.selectedSegmentIndex];
        animal.genero = [_genderSegControl titleForSegmentAtIndex:_genderSegControl.selectedSegmentIndex];
        animal.porte = [_sizeSegControl titleForSegmentAtIndex:_sizeSegControl.selectedSegmentIndex];
        
        [animal save];
        [self performSegueWithIdentifier:@"RegisterAnimalSegue" sender:nil];
    }
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) mainPhotoDoesExist
{
    if ([_mainImage backgroundImageForState:UIControlStateNormal] == nil){
        UIAlertView *alertEmptyImage = [[UIAlertView alloc] initWithTitle:@"Campos incompletos" message:@"Por favor, insira uma imagem." delegate: self cancelButtonTitle:@"OK"otherButtonTitles: nil];
        [alertEmptyImage show];
        return NO;
    }
    else
        return YES;
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [UIImage cropImageWithInfo:info];
    [_imageHolder setBackgroundImage:image forState:UIControlStateNormal];
    [_imageHolder setTitle:@"" forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)setFirstImage:(UIButton *)sender {
    _imageHolder = sender;
    UIImagePickerController *imagePickerControllerMain = [[UIImagePickerController alloc] init];
    imagePickerControllerMain.allowsEditing = YES;
    
    imagePickerControllerMain.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerControllerMain.delegate = self;
    [self presentViewController:imagePickerControllerMain animated:NO completion:nil];
}

- (BOOL) emptyFieldsExist{
    if ([_nameTextFielld.text length] == 0 ||
        [_cityTextField.text length] == 0 ||
        [_descriptionTextView.text  isEqual: @""])
    {
        UIAlertView *alertEmptyFields = [[UIAlertView alloc] initWithTitle:@"Campos incompletos" message:@"Por favor, preencha todos os campos." delegate: self cancelButtonTitle:@"OK"otherButtonTitles: nil];
        [alertEmptyFields show];
        return YES;
    }
    return NO;
    
}

- (IBAction)ageStepperValueChanged:(id)sender {
    _ageLabel.text = [NSString stringWithFormat:@"%1.f", _ageStepper.value];
}


- (void)stopSignificantChangesUpdates
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = placemarks[0];
        NSDictionary *addressDictionary = [placemark addressDictionary];
        _cityTextField.text = addressDictionary[(NSString *)kABPersonAddressCityKey];
        
    }];
    
    [self stopSignificantChangesUpdates];
}


@end
