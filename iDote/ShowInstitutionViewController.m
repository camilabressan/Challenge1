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

@implementation ShowInstitutionViewController

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

@end