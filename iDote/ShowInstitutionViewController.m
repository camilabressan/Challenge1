//
//  ShowInstitutionViewController.m
//  iDote
//
//  Created by Eduardo Santi on 25/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "ShowInstitutionViewController.h"

@interface ShowInstitutionViewController ()

@end

@implementation ShowInstitutionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InstitutionTableViewCell *cell = (InstitutionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSString *ndxName = [NSString stringWithFormat:@"Nome: %li", indexPath.row + 1];
    cell.nameInstitution.text = ndxName;
    
    NSString *ndxPhone = [NSString stringWithFormat:@"Phone: %li", indexPath.row + 1];
    cell.phoneInstitution.text = ndxPhone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //capturar o indexPath da cell e enviar para o detailInstitution
}




@end
