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

@property NSString *username;
@property NSString *email;
@property NSString *password;

- (void) login;
- (void) cadastrar;
@end
