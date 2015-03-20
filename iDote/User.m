//
//  User.m
//  iDote
//
//  Created by Eduardo Santi on 19/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "User.h"

@implementation User

- (void) cadastrar {
  _object = [[PFUser alloc] init];
  _object.username = _email;
  _object.password = _password;
  [_object signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    if (succeeded) {
    
    } else {
      //TODO: erro cadastro
    }
  }];
}

- (void) login {


}

@end
