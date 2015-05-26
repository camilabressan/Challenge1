//
//  InterfaceController.m
//  Pet's Bay WatchKit Extension
//
//  Created by Jonathan Andrade on 21/05/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "InterfaceController.h"
#import <Parse/Parse.h>


@interface InterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblName;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)handleUserActivity:(NSDictionary *)userInfo{
    NSString* objId = [userInfo valueForKey:@"animalId"];
    PFQuery *query = [PFQuery queryWithClassName:@"Animal"];
    [query whereKey:@"objectId" equalTo:objId];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            [self pushControllerWithName:@"AnimalDetailScreen" context:object];
            //[_lblName setText:[object objectForKey:@"name"]];
        }
    }];
    
    
    NSLog(@"%@", objId);
}

@end



