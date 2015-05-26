//
//  AnimalDetailsController.h
//  iDote
//
//  Created by Jonathan Andrade on 26/05/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


@interface AnimalDetailsController : WKInterfaceController
@property PFObject *animal;
@end
