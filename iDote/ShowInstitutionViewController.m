//
//  ShowInstitutionViewController.m
//  iDote
//
//  Created by Eduardo Santi on 25/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "ShowInstitutionViewController.h"
#import <Parse/Parse.h>

@interface ShowInstitutionViewController ()

@property NSMutableArray *list;

@end

@implementation ShowInstitutionViewController{
    UINavigationController *_navController;
    Institution *_institution;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _list = [Institution loadInstitution];
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:_refreshControl];
}

-(void) refresh{
    _list = [Institution loadInstitution];
    [_tableView reloadData];
    [_refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InstitutionTableViewCell *cell = (InstitutionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.nameInstitution.text = [(Institution *)_list[indexPath.row] institutionName];
    cell.phoneInstitution.text = [(Institution *)_list[indexPath.row] institutionPhone];
    
    
    if ([(Institution *)_list[indexPath.row] mainImage] != nil) {
        cell.imageInstitution.image = [(Institution *)_list[indexPath.row] mainImage];
    } else {
        PFFile *photo = [[(Institution *)_list[indexPath.row] object] valueForKey:@"foto"];
        if (photo != nil) {
            cell.imageInstitution.image = [UIImage imageNamed:@"300"];
            NSURL *imageURL = [[NSURL alloc] initWithString:[photo url]];
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                NSData *data = [NSData dataWithContentsOfURL:imageURL];
                UIImage *image = [UIImage imageWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [(Institution *)_list[indexPath.row] setMainImage:image];
                    cell.imageInstitution.image = image;
                });
            });
        }
    }

    cell.institution = _list[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(InstitutionTableViewCell *)sender{
    
    if ([segue.identifier isEqualToString:@"segueDetailInstitution"]) {
        DetailInstitutionViewController *detail = (DetailInstitutionViewController *)segue.destinationViewController;
        
        detail.inst = sender.institution;
    }

}

- (IBAction)clickAddButton:(id)sender {
    [self ShowRegisterInstitutionForm];
}

- (void) ShowRegisterInstitutionForm {
    FXFormViewController *controller = [[FXFormViewController alloc] init];
    controller.formController.form = [[Institution alloc] init];
    
    _navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
    controller.navigationItem.title = @"Dados da Instituição";
    controller.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Salvar" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    
    [self presentViewController:_navController animated:YES completion:nil];
}

- (void)dismiss:(id)sender {
    [_navController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)save:(id)sender {
    FXFormViewController *formQueVoltou = (FXFormViewController*)_navController.topViewController;
    _institution = formQueVoltou.formController.form;
    
    if ([self emptyTextFieldExistent] == NO){
        [_institution save];
        [_navController dismissViewControllerAnimated:NO completion:^{
        }];
    }
}

-(BOOL) emptyTextFieldExistent
{
    if (_institution.institutionName == nil ||
        _institution.institutionPhone == nil ||
        _institution.institutionEmail == nil ||
        _institution.institutionResponsible == nil ||
        _institution.institutionDescription == nil)
    {
        UIAlertView *alertEmptyFields = [[UIAlertView alloc] initWithTitle:@"Campos incompletos" message:@"Por favor, preencha todos os campos obrigatórios." delegate: self cancelButtonTitle:@"OK"otherButtonTitles: nil];
        [alertEmptyFields show];
        return YES;
    }
    return NO;
}

@end