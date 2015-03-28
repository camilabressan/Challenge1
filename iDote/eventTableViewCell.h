//
//  eventTableViewCell.h
//  iDote
//
//  Created by Jonathan Andrade on 27/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Evento.h"

@interface eventTableViewCell : UITableViewCell

@property Evento *event;

@property (weak, nonatomic) IBOutlet UILabel *labelEventDay;
@property (weak, nonatomic) IBOutlet UILabel *labelEventName;
@property (weak, nonatomic) IBOutlet UILabel *labelEventWeekDay;

@end
