//
//  RegisterAnimalViewController.h
//  iDote
//
//  Created by Jonathan Andrade on 15/04/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UIImage+Resize.h"
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import "Animal.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface RegisterAnimalViewController : UITableViewController <UIImagePickerControllerDelegate, UIWebViewDelegate,  CLLocationManagerDelegate, MKMapViewDelegate,  CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *mainImage;
@property(nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextFielld;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UIStepper *ageStepper;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sizeSegControl;

@end
