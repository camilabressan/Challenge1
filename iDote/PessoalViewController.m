//
//  PessoalViewController.m
//  iDote
//
//  Created by Eduardo Santi on 28/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "PessoalViewController.h"

@interface PessoalViewController ()

@property NSMutableArray *listAnimals;
@property NSMutableArray *listEvents;

@end

@implementation PessoalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _user = [User loadCurrentUser];
    _listAnimals = [Animal loadAnimalsFromUser];
    _listEvents = [Evento loadEventsFromUser];
    
    _tableView.allowsSelection = NO;
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];

    [self.tableView addSubview:_refreshControl];
    
    [self showData];
}

-(void)showData{
    _pessoalName.text = _user.name;
    _pessoalEmail.text = _user.email;
    _pessoalPhone.text = _user.phone;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PessoalCellTableViewCell *cell = (PessoalCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (_segmentedControl.selectedSegmentIndex == 0) {
        cell.cellName.text = [(Animal *)_listAnimals[indexPath.row] nome];
        
        cell.animal = _listAnimals[indexPath.row];
    }
    
    if (_segmentedControl.selectedSegmentIndex == 1) {
        cell.cellName.text = [(Evento *)_listEvents[indexPath.row] nomeEvento];
        
        cell.event = _listEvents[indexPath.row];
    }
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_segmentedControl.selectedSegmentIndex == 0) {
        return _listAnimals.count;
    }
    
    return  _listEvents.count;
    
}

- (IBAction)checkSegmented:(id)sender {
    [_tableView reloadData];
}

-(void) refresh{
    _listAnimals = [Animal loadAnimalsFromUser];
    _listEvents = [Evento loadEventsFromUser];
    [_tableView reloadData];
    [_refreshControl endRefreshing];
}


- (IBAction)profileDataChanged:(id)sender {
    _buttonSave.enabled = YES;
}

- (IBAction)saveClick:(id)sender {
    
    _user.name = _pessoalName.text;
    _user.username = _pessoalEmail.text;
    _user.email = _pessoalEmail.text;
    _user.phone = _pessoalPhone.text;
    [_user updateData];
    
    UIAlertView *alertSaveSuccess = [[UIAlertView alloc] initWithTitle:@"Perfil salvo" message:@"As mudanças em seu perfil foram salvas com sucesso." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertSaveSuccess show];
    _buttonSave.enabled = NO;
    
}

@end
