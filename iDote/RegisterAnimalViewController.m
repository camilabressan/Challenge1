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
    // Do any additional setup after loading the view.
    
    _mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        //[self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
#endif
    [self.locationManager startUpdatingLocation];
    
    _mapView.showsUserLocation = YES;
    [_mapView setMapType:MKMapTypeStandard];
    [_mapView setZoomEnabled:YES];
    [_mapView setScrollEnabled:YES];
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

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    NSLog(@">>>>>%@", [self deviceLocation]);
    
    //View Area
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.locationManager.location.coordinate.latitude;
    region.center.longitude = self.locationManager.location.coordinate.longitude;
    region.span.longitudeDelta = 0.005f;
    region.span.longitudeDelta = 0.005f;
    [_mapView setRegion:region animated:YES];
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}

- (NSString *)deviceLat {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
}

- (NSString *)deviceLon {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
}

- (NSString *)deviceAlt {
    return [NSString stringWithFormat:@"%f", self.locationManager.location.altitude];
}

//

- (void)startSignificantChangeUpdates
{
    if ([CLLocationManager locationServicesEnabled])
    {
        if (!self.locationManager)
            self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;
        [self.locationManager startMonitoringSignificantLocationChanges];
    }
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
