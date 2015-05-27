//
//  GlanceController.m
//  Pet's Bay WatchKit Extension
//
//  Created by Jonathan Andrade on 21/05/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "GlanceController.h"
//#import <Parse/Parse.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface GlanceController()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *animalNameLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *glanceGroup;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *ownerImageGroup;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *ownerNameLabel;

@end


@implementation GlanceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Initialize Parse.
    [Parse setApplicationId:@"RDeAF8POAUsEEwGwuXQT7MJnV3eZ78T4wMQ9zsTM"
                  clientKey:@"NpZ235fSV6ygvZSgRq70kQxolsXPer8B3CMXoU4e"];
    // Configure interface objects here.
    

}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    
    PFQuery *query = [PFQuery queryWithClassName:@"Animal"];
    query.limit = 1;
    [query orderByDescending:@"createdAt"];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        PFObject *lastAnimal = [query getFirstObject];
        NSURL *imgURL = [[NSURL alloc] initWithString:[(PFFile *)[lastAnimal objectForKey:@"mainPhoto"] url]];
       // NSURL *ownerImgURL = [[NSURL alloc] initWithString:[(PFFile *)[lastAnimal objectForKey:@"user"]]] ;
        
        PFRelation *relation = [lastAnimal objectForKey:@"user"];
        PFQuery *query = [relation query];
        
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if (!error) {
                PFUser *user = (PFUser *)object;
                NSURL *ownerImgURL = [[NSURL alloc] initWithString:[(PFFile *)user[@"mainPhoto"] url]] ;
                NSData *dataAux = [NSData dataWithContentsOfURL:ownerImgURL];
                UIImage *ownerImage = [UIImage imageWithData:dataAux];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.ownerImageGroup setCornerRadius:20.0];
                    [self.ownerImageGroup setBackgroundImage:ownerImage];
                    NSString *ownerName = user[@"Name"];
                    NSArray *array = [ownerName componentsSeparatedByString:@" "];
                    [self.ownerNameLabel setText:array[0]];
                });

            }
        }];
        
        NSData *data = [NSData dataWithContentsOfURL:imgURL];
        UIImage *image = [UIImage imageWithData:data];
        [self.glanceGroup setCornerRadius: 4.0];
        
        [self updateUserActivity:@"com.bepid.iDote.glance"
                        userInfo:@{@"animalId": [lastAnimal valueForKey:@"objectId"]}
                      webpageURL:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.animalNameLabel setText:lastAnimal[@"name"]];
            [self.glanceGroup setBackgroundImage:image];
        });
    });

    
    [super willActivate];
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end

