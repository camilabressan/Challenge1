//
//  CardView.m
//  Tinder Navigation Test
//
//  Created by Adriano Soares on 20/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "CardView.h"
#import "SwipeCardView.h"

@interface CardView ()
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic) NSMutableArray *swipeCardsArray;
@property (nonatomic) NSMutableArray *data;
@property (nonatomic, strong) SwipeCardView *swipeView;

@end

@implementation CardView

- (id)init
{
    self = [super init];
    if (!self) return nil;
    _currentIndex = 0;
    _swipeCardsArray = [[NSMutableArray alloc] initWithCapacity:3];
    _data = [Animal loadAnimals];
    
    for (int i = 0; i < 3; i++) {
        [_swipeCardsArray addObject:[NSNull null]];
    }
    
    
    self.backgroundColor = [UIColor whiteColor];
    self.contentMode = UIViewContentModeCenter;
    [self loadCustomView];
    
    return self;
}

- (void)loadCustomView
{
    
    [_swipeCardsArray insertObject:[[SwipeCardView alloc] initWithData:_data[0]] atIndex:1];
    ((SwipeCardView *)_swipeCardsArray[1]).position = SwipeCardPositionCenter;
    [self addSubview:_swipeCardsArray[1]];
    
    [_swipeCardsArray insertObject:[[SwipeCardView alloc] initWithData:_data[1]] atIndex:2];
    ((SwipeCardView *)_swipeCardsArray[2]).position = SwipeCardPositionRight;
    [self addSubview:_swipeCardsArray[2]];
}



- (void)layoutSubviews {
    [super layoutSubviews];
    for (SwipeCardView *card in _swipeCardsArray) {
        if ([card respondsToSelector:@selector(moveLeft)]) {
            card.frame = CGRectMake(0,
                                    0,
                                    self.frame.size.width *0.75,
                                    self.frame.size.width *0.90);
            
            switch (card.position) {
                case SwipeCardPositionLeft:
                    card.center = CGPointMake(0 - self.frame.size.width * 0.3,
                                              self.center.y);
                    break;
                case SwipeCardPositionCenter:
                    card.center = self.center;
                    break;
                case SwipeCardPositionRight:
                    card.center = CGPointMake(self.frame.size.width *1.3,
                                              self.center.y);
                    break;
            }
        }
    }
    
}

- (void)swipeLeft {
    if (_currentIndex < [_data count] - 1) {
        for (int i = 0; i < _swipeCardsArray.count; i++) {
            SwipeCardView *card = _swipeCardsArray[i];
            if ([card respondsToSelector:@selector(moveLeft)]) {
                [card moveLeft];
            }
            
            if (i >= 1) {
                _swipeCardsArray[i-1] = card;
                if (i == _swipeCardsArray.count - 1 && _currentIndex < [_data count] -2) {
                    SwipeCardView *newCard = [[SwipeCardView alloc] initWithData:_data[_currentIndex+2]];
                    _swipeCardsArray[i] = newCard;
                    newCard.position = SwipeCardPositionRight;
                    [self addSubview:newCard];
                }
            }
        }
        _currentIndex++;
    }
    
}

- (void)swipeRight {
    if (_currentIndex > 0) {
        for (int i = (int)_swipeCardsArray.count -1; i >= 0; i--) {
            SwipeCardView *card = _swipeCardsArray[i];
            if ([card respondsToSelector:@selector(moveRight)]) {
                [card moveRight];
            }
            
            if (i <= _swipeCardsArray.count - 2) {
                _swipeCardsArray[i+1] = card;
                if (i == 0 && _currentIndex > 1) {
                    SwipeCardView *newCard = [[SwipeCardView alloc] initWithData:_data[_currentIndex-2]];
                    _swipeCardsArray[i] = newCard;
                    newCard.position = SwipeCardPositionLeft;
                    [self addSubview:newCard];
                }
            
            }
        }
        _currentIndex--;
    }
    
}



@end
