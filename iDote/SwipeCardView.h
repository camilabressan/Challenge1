//
//  SwipeCardView.h
//  Tinder Navigation Test
//
//  Created by Adriano Soares on 21/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SwipeCardPosition) {
  SwipeCardPositionLeft,
  SwipeCardPositionCenter,
  SwipeCardPositionRight
};

@interface SwipeCardView : UIView {
  double animationTime;
}


@property SwipeCardPosition position;
@property id data;

- (void) moveLeft;
- (void) moveRight;

@end
