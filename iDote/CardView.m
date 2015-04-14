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
@property float blurAmount;

@end

@implementation CardView

- (id)init
{
    self = [super init];
    if (!self) return nil;
    _currentIndex = 0;
    _swipeCardsArray = [[NSMutableArray alloc] init];

    _blurAmount = 0.5;
    
    _blurImage = [[UIImageView alloc] init];
    _blurImage.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_blurImage];
    
    _data = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        [_swipeCardsArray addObject:[NSNull null]];
    }
    [self loadData];
    
    self.backgroundColor = [UIColor whiteColor];
    self.contentMode = UIViewContentModeCenter;
    
    
    return self;
}

- (void)loadData {
    _currentIndex = 0;
    _blurImage.image = nil;
    for (UIView *view in [self subviews]) {
        if (view != _blurImage) {
            [view removeFromSuperview];
        }
        
    }
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        _data = [Animal loadAnimals];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_data.count > 0) {
                [self loadCustomView];
            } else {
                [self performSelector:@selector(loadData)
                           withObject:nil
                           afterDelay:5.0];
            
            }
            
            
        });
    });
}

- (void)loadCustomView
{
    if (_data.count > 0) {
        _swipeCardsArray[1] = [[SwipeCardView alloc] initWithData:_data[0]];
        ((SwipeCardView *)_swipeCardsArray[1]).position = SwipeCardPositionCenter;
        [self addSubview:_swipeCardsArray[1]];
        if (((Animal *)_data[0]).mainImage == nil) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                NSURL *urlImage = [[NSURL alloc] initWithString:((Animal *)_data[0]).mainImageURL];
                NSData *data = [NSData dataWithContentsOfURL: urlImage];
                UIImage *image = [[UIImage imageWithData:data] blurredImage:_blurAmount] ;
                dispatch_async(dispatch_get_main_queue(), ^{
                  _blurImage.image = image;
                });
            });
        } else {
            UIImage *image = [((Animal *)_data[0]).mainImage blurredImage:_blurAmount] ;
            _blurImage.image = image;
        }

    
    }
    if (_data.count > 1) {
        _swipeCardsArray[2] = [[SwipeCardView alloc] initWithData:_data[1]];;
        ((SwipeCardView *)_swipeCardsArray[2]).position = SwipeCardPositionRight;
        [self addSubview:_swipeCardsArray[2]];
    
    }
    

}



- (void)layoutSubviews {
    [super layoutSubviews];
    _blurImage.frame = self.frame;
    
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
    if (_currentIndex < ((long) [_data count]) - 1 ) {
        for (int i = 0; i < _swipeCardsArray.count; i++) {
            SwipeCardView *card = _swipeCardsArray[i];
            if ([card respondsToSelector:@selector(moveLeft)]) {
                [card moveLeft];
                if (card.position == SwipeCardPositionCenter) {
                    if (card.data.mainImage == nil) {
                        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
                        dispatch_async(queue, ^{
                            NSURL *urlImage = [[NSURL alloc] initWithString:(card.data).mainImageURL];
                            NSData *data = [NSData dataWithContentsOfURL: urlImage];
                            UIImage *image = [[UIImage imageWithData:data] blurredImage:_blurAmount] ;
                            dispatch_async(dispatch_get_main_queue(), ^{
                                _blurImage.image = image;
                            });
                        });
                    } else {
                        UIImage *image = [card.data.mainImage blurredImage:_blurAmount] ;
                        _blurImage.image = image;
                    }

                }

                if (i == 0) {
                    [(SwipeCardView *)_swipeCardsArray[i] removeFromSuperview];
                    _swipeCardsArray[i] = [NSNull null];
                }
            }
            if (i > 0) {
                _swipeCardsArray[i-1] = card;
                if (i == _swipeCardsArray.count - 1 && _currentIndex < [_data count] -2) {
                    SwipeCardView *newCard = [[SwipeCardView alloc] initWithData:_data[_currentIndex+2]];
                    _swipeCardsArray[i] = newCard;
                    newCard.position = SwipeCardPositionRight;
                    [self addSubview:newCard];
                } else {
                    _swipeCardsArray[i] = [NSNull null];
                
                }
            }
            

        }

        _currentIndex++;
        if (_currentIndex >= _data.count -1) { //Load New Data async
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                NSMutableArray *newData = [Animal loadNewAnimals:_data[_data.count-1]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_data addObjectsFromArray:newData];
                    if (_swipeCardsArray[2] == [NSNull null] && newData.count > 0) {
                        SwipeCardView *newCard = [[SwipeCardView alloc] initWithData:_data[_currentIndex+1]];
                        _swipeCardsArray[2] = newCard;
                        newCard.position = SwipeCardPositionRight;
                        [self addSubview:newCard];
                    }
                });
            });
        }
        
        if (_currentIndex >= 5) {
            ((Animal *)_data[_currentIndex-5]).mainImage = nil;
        }
    }
    
}

- (void)swipeRight {
    if (_currentIndex > 0) {

        for (int i = (int)_swipeCardsArray.count -1; i >= 0; i--) {
            SwipeCardView *card = _swipeCardsArray[i];
            if ([card respondsToSelector:@selector(moveRight)]) {
                [card moveRight];
                if (card.position == SwipeCardPositionCenter) {
                    if (card.data.mainImage == nil) {
                        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
                        dispatch_async(queue, ^{
                            NSURL *urlImage = [[NSURL alloc] initWithString:(card.data).mainImageURL];
                            NSData *data = [NSData dataWithContentsOfURL: urlImage];
                            UIImage *image = [[UIImage imageWithData:data] blurredImage:_blurAmount] ;
                            dispatch_async(dispatch_get_main_queue(), ^{
                                _blurImage.image = image;
                            });
                        });
                    } else {
                        UIImage *image = [card.data.mainImage blurredImage:_blurAmount] ;
                        _blurImage.image = image;
                    }
                    
                }

                if (i == _swipeCardsArray.count - 1) {
                    [(SwipeCardView *)_swipeCardsArray[i] removeFromSuperview];
                    _swipeCardsArray[i] = [NSNull null];
                }
            }
            if (i < _swipeCardsArray.count - 1) {
                _swipeCardsArray[i+1] = card;
                if (i == 0 && _currentIndex > 1) {
                    SwipeCardView *newCard = [[SwipeCardView alloc] initWithData:_data[_currentIndex-2]];
                    _swipeCardsArray[i] = newCard;
                    newCard.position = SwipeCardPositionLeft;
                    [self addSubview:newCard];
                } else {
                    _swipeCardsArray[i] = [NSNull null];
                
                }
                
            }


        }
        _currentIndex--;
        
    }
    
}



@end
