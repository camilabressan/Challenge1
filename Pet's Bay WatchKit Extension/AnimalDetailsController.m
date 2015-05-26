//
//  AnimalDetailsController.m
//  iDote
//
//  Created by Jonathan Andrade on 26/05/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "AnimalDetailsController.h"

@interface AnimalDetailsController()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *animalNameLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *animalImageGroup;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *animalSizeLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *animalGenderLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *animalAgeLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *animalDetailsLabel;

@end


@implementation AnimalDetailsController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    _animal = context;
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    if (_animal != nil){
        [_animalNameLabel setText: [_animal valueForKey:@"name"]];
        [_animalSizeLabel setText: [_animal valueForKey:@"size"]];
        [_animalGenderLabel setText: [_animal valueForKey:@"gender"]];
        [_animalDetailsLabel setText:[_animal objectForKey:@"description"]];
        
        NSNumber *ageNumber = [_animal valueForKey:@"age"];
        
        NSString *ageRange;
        if ( ageNumber.intValue <= 3) {
            ageRange = @"0 - 3 anos";
        } else if (ageNumber.intValue <= 7) {
            ageRange = @"4 - 7 anos";
        } else {
            ageRange = @"8 ou mais anos";
        }
        [_animalAgeLabel setText: ageRange];
        
        [self.animalImageGroup setCornerRadius: 35.0];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSURL *imgURL = [[NSURL alloc] initWithString:[(PFFile *)[_animal objectForKey:@"mainPhoto"] url]];
            NSData *data = [NSData dataWithContentsOfURL:imgURL];
            UIImage *image = [UIImage imageWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.animalImageGroup setBackgroundImage:image];
            });
        });
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)handleUserActivity:(NSDictionary *)userInfo{
    /*NSString* objId = [userInfo valueForKey:@"animalId"];
     PFQuery *query = [PFQuery queryWithClassName:@"Animal"];
     [query whereKey:@"objectId" equalTo:objId];
     
     [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
     if (!error) {
     [_lblName setText:[object objectForKey:@"name"]];
     }
     }];
     
     
     NSLog(@"%@", objId);*/
}

@end



