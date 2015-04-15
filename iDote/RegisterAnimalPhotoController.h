//
//  RegisterAnimalPhotoController.h
//  iDote
//
//  Created by Jonathan Andrade on 23/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animal.h"


@interface RegisterAnimalPhotoController : UIViewController <UIImagePickerControllerDelegate, UIWebViewDelegate,  CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *mainImage;
@property(nonatomic, retain) CLLocationManager *locationManager;

@end