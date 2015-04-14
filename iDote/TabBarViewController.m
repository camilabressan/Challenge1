//
//  TabBarViewController.m
//  iDote
//
//  Created by Camila Bressan Inácio on 24/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "TabBarViewController.h"
#import "UIImage+Extension.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [[UITabBar appearance] setTintColor: [UIColor colorWithRed:240/255.0 green:167/255.0 blue:59/255.0 alpha:1]];
    //MUDANDO A COR DO ICONE DA TAB BAR PRESSIONADO
    
    [[UIBarButtonItem appearance] setTintColor: [UIColor colorWithRed:234/255.0 green:158/255.0 blue:63/255.0 alpha:1]]; //MUDA A COR DOS ICONES DA NAVIGATION

    [[UITabBar appearance] setBarTintColor: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]]; // MUDA A COR DA TAB BAR
//
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:234/255.0 green:158/255.0 blue:63/255.0 alpha:1]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    //MUDANDO A COR DO BOTAO PADRAO DA NAVIGATION

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
