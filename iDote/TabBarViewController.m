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
    
    // Do any additional setup after loading the view.
    
    [[UITabBar appearance] setTintColor: [UIColor colorWithRed:241/255.0 green:59/255.0 blue:125/255.0 alpha:1]];
    //MUDANDO A COR DO ICONE DA TAB BAR PRESSIONADO
    
    [[UIBarButtonItem appearance] setTintColor: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]]; //MUDA A COR DOS ICONES DA NAVIGATION
    
    [[UITabBar appearance] setBarTintColor: [UIColor colorWithRed:111/255.0 green:17/255.0 blue:45/255.0 alpha:1]]; // MUDA A COR DA TAB BAR
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:(255.0/255.0) green:(255.0/255.0) blue:(255.0/255.0) alpha:1]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //MUDANDO A COR DO BOTAO PADRAO DA NAVIGATION
    
    
    // Colocando cor nos textos do item da tab bar
    [self.tabBar setTintColor:[UIColor whiteColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    
    UIColor * unselectedColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:unselectedColor, NSForegroundColorAttributeName, nil]
                                             forState:UIControlStateNormal];
    
    // generate a tinted unselected image based on image passed via the storyboard
    for(UITabBarItem *item in self.tabBar.items) {
        // use the UIImage category code for the imageWithColor: method
        // item.image = [[item.selectedImage [UIImage imageWithColor:unselectedColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
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
