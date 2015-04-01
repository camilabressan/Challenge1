//
//  CardView.h
//  Tinder Navigation Test
//
//  Created by Adriano Soares on 20/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animal.h"
#import "SwipeCardView.h"

@interface CardView : UIView
@property (nonatomic, strong) SwipeCardView *swipeView;


- (void) swipeLeft;
- (void) swipeRight;

@end
