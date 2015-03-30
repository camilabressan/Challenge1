//
//  User.h
//  iDote
//
//  Created by Eduardo Santi on 19/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface User : NSObject
@property PFUser *object;

@property NSString *mainImageURL;

@property UIImage *mainImage;
@property NSString *username;
@property NSString *email;
@property NSString *password;
@property NSString *name;
@property NSString *phone;

+ (User *) loadCurrentUser;
+ (User *) loadUserFromRelation:(PFRelation *)relation;

- (void) login;
- (void) cadastrar;
@end
