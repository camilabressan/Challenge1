//
//  ShowInstitutionViewController.m
//  iDote
//
//  Created by Eduardo Santi on 25/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "ShowInstitutionViewController.h"

@interface ShowInstitutionViewController ()

@property NSMutableArray *list;

@end

@implementation ShowInstitutionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _list = [Institution loadInstitution];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InstitutionTableViewCell *cell = (InstitutionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //NSString *ndxName = [NSString stringWithFormat:@"Nome: %li", indexPath.row + 1];
    //cell.nameInstitution.text = ndxName;
    cell.nameInstitution.text = [(Institution *)_list[indexPath.row] institutionName];
    cell.phoneInstitution.text = [(Institution *)_list[indexPath.row] institutionPhone];
    
    //NSString *ndxPhone = [NSString stringWithFormat:@"Phone: %li", indexPath.row + 1];
    //cell.phoneInstitution.text = ndxPhone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //capturar o indexPath da cell e enviar para o detailInstitution
    
    
    if ([segue.identifier isEqualToString:@"segueDetailInstitution"]) {
        DetailInstitutionViewController *detail = (DetailInstitutionViewController *)segue.destinationViewController;
        
        detail.inst = _list[0];
        detail.inst = _list[1];
    }

}




@end
