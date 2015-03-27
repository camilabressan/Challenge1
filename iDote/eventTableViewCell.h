//
//  eventTableViewCell.h
//  iDote
//
//  Created by Jonathan Andrade on 27/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface eventTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelEventDate;
@property (weak, nonatomic) IBOutlet UILabel *labelEventName;

@end
