//
//  AnimalsShowViewController.m
//  iDote
//
//  Created by Jonathan Andrade on 24/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "AnimalsShowViewController.h"
#import "AnimalDetailsViewController.h"
#import "CardView.h"

@interface AnimalsShowViewController () <UITextFieldDelegate>
@property (nonatomic) UISwipeGestureRecognizer *swipeLeftRecognizer;
@property (nonatomic) UISwipeGestureRecognizer *swipeRightRecognizer;

@property CardView* cardView;
@end

@implementation AnimalsShowViewController

-(void)viewDidLoad {
    [super viewDidLoad];    
    
    _swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                     action:@selector(swipeLeftHandler:)];
    [_swipeLeftRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:_swipeLeftRecognizer];
    
    _swipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                      action:@selector(swipeRightHandler:)];
    [_swipeRightRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:_swipeRightRecognizer];
    
    _cardView = [[CardView alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tapCenter:)
                                                 name:@"TapCenter"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(swipeLeftHandler:)
                                                 name:@"TapLeft"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(swipeRightHandler:)
                                                 name:@"TapRight"
                                               object:nil];
}

-(IBAction)backFromRegisterAnimal:(UIStoryboardSegue *)sender {
    
}

- (void) tapCenter:(NSNotification *) notification {
    Animal *animal = (Animal *)notification.object;
    [self performSegueWithIdentifier:@"ShowAnimalSegue" sender:animal];
}


- (void) swipeLeftHandler:(UISwipeGestureRecognizer *)gesture {
    [_cardView swipeLeft];
}
- (void) swipeRightHandler:(UISwipeGestureRecognizer *)gesture {
    [_cardView swipeRight];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowAnimalSegue"]) {
        AnimalDetailsViewController *dvc = (AnimalDetailsViewController *)segue.destinationViewController;
        dvc.animal = (Animal *)sender;
    }

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _cardView.frame = self.view.frame;
    [self.view addSubview:_cardView];
    
}

- (IBAction)touchDownBackground:(id)sender {
    [self.view endEditing:YES];
}

@end
