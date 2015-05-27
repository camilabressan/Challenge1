//
//  NotificationController.m
//  Pet's Bay WatchKit Extension
//
//  Created by Jonathan Andrade on 21/05/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "NotificationController.h"


@interface NotificationController()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblCity;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *imgNotification;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblAlert;

@end


@implementation NotificationController

- (instancetype)init {
    self = [super init];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        
    }
    return self;
}

- (void)willActivate {
    
    // This method is called when watch view controller is about to be visible to user
    [_imgNotification setImageNamed:@"idote_00"];
    
    NSRange range = NSMakeRange(00, 12);
    [_imgNotification startAnimatingWithImagesInRange:range duration:0.5 repeatCount:-1];
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}



/*
- (void)didReceiveLocalNotification:(UILocalNotification *)localNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a local notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}
*/


- (void)didReceiveRemoteNotification:(NSDictionary *)remoteNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a remote notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.

    [_lblAlert setText:[[remoteNotification valueForKey:@"aps"] valueForKey:@"alert"]];
    [_lblCity setText:[remoteNotification valueForKey:@"city"]];
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}


@end



