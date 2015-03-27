//
//  Institution.h
//  iDote
//
//  Created by Tainara Specht on 3/22/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Institution : NSObject

@property PFObject *object;

@property NSString *institutionName;
@property NSString *institutionPhone;
@property NSString *institutionEmail;
@property NSString *institutionResponsible;
@property NSString *institutionAddress;
@property NSString *institutionDescription;
@property UIImage *mainImage;
@property BOOL *ativo;

-(void) save;
+(NSMutableArray* ) loadInstitution;


@end
