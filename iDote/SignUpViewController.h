//
//  SignUpViewController.h
//  iDote
//
//  Created by Jonathan Andrade on 20/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "VMaskTextField.h"

@interface SignUpViewController : UIViewController <UITextFieldDelegate>
@property PFUser *user;

@end
