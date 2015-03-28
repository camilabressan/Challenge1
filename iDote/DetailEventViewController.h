//
//  DetailEventViewController.h
//  iDote
//
//  Created by Eduardo Santi on 27/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Evento.h"

@interface DetailEventViewController : UIViewController

@property Evento *ev;

@property (weak, nonatomic) IBOutlet UILabel *detailNameEvent;
@property (weak, nonatomic) IBOutlet UILabel *detailAddress;
@property (weak, nonatomic) IBOutlet UILabel *detailDate;
@property (weak, nonatomic) IBOutlet UILabel *detailHour;
@property (weak, nonatomic) IBOutlet UITextView *detailDescription;

@end
