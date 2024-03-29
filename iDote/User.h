//
//  User.h
//  iDote
//
//  Created by Eduardo Santi on 19/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "FXForms.h"

@interface User : NSObject <FXForm>
@property PFUser *object;

@property NSString *mainImageURL;

@property UIImage *mainImage;
@property NSString *username;
@property NSString *email;
@property NSString *password;
@property NSString *confirmPassword;
@property NSString *name;
@property NSString *phone;

+ (User *) loadCurrentUser;
+ (User *) loadUserFromObject:(PFObject *)object;

- (void) login;
- (void) cadastrar;
- (void) updateData;
- (void) save;
@end
