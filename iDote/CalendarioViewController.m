//
//  CalendarioViewController.m
//  iDote
//
//  Created by Camila Bressan Inácio on 23/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "CalendarioViewController.h"



@interface CalendarioViewController (){
    
    NSDictionary *meses; //criando dicionario
    NSArray *tabelacalendario; //criando array
}


@end

@implementation CalendarioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    
    tabelacalendario = @[@"Janeiro", //implementando array
                         @"Fevereiro",
                         @"Marco",
                         @"Abril",
                         @"Maio",
                         @"Junho",
                         @"Julho",
                         @"Agosto",
                         @"Setembro",
                         @"Outubro",
                         @"Novembro",
                         @"Dezembro"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [tabelacalendario count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [tabelacalendario objectAtIndex:section]; //imprimir titulo no cabeçalho
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *sectionTitle = [tabelacalendario objectAtIndex:section];
    NSArray *sectionMeses = [meses objectForKey:sectionTitle];
    return [sectionMeses count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *sectionTitle = [tabelacalendario objectAtIndex:indexPath.section];
    NSArray *tabelacalendario = [meses objectForKey:sectionTitle];
    NSString *meses = [tabelacalendario objectAtIndex:indexPath.row];
    cell.textLabel.text = meses;
    //cell.imageView.image = [UIImage imageNamed:[self getImageFilename:meses]];
    
    return cell;
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
