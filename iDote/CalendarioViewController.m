//
//  CalendarioViewController.m
//  iDote
//
//  Created by Camila Bressan Inácio on 23/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "CalendarioViewController.h"


@interface CalendarioViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary *meses; //criando dicionario
    NSArray *tabelacalendario; //criando array
    
    NSMutableArray *monthArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableViewEvents;
@end

@implementation CalendarioViewController{
    NSArray *allEvents;
    UIDatePicker *datePicker;
    UINavigationController *_navController;
    Evento *_event;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_TabelaCalendario deselectRowAtIndexPath:self.TabelaCalendario.indexPathForSelectedRow animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.TabelaCalendario addSubview:_refreshControl];
    
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    
    tabelacalendario = @[@"Janeiro", //implementando array
                         @"Fevereiro",
                         @"Março",
                         @"Abril",
                         @"Maio",
                         @"Junho",
                         @"Julho",
                         @"Agosto",
                         @"Setembro",
                         @"Outubro",
                         @"Novembro",
                         @"Dezembro"];
    

    [self loadEvents];
}

-(void) refresh{
    [self loadEvents];
    [_TabelaCalendario reloadData];
    [_refreshControl endRefreshing];
}

- (void) sortEventsByDay {
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    allEvents = [allEvents sortedArrayUsingDescriptors:sortDescriptors];
    
    
}

- (void) loadEvents {
    monthArray = [[NSMutableArray alloc] init];
    for (int i = 0; i< tabelacalendario.count; i++) {
        [monthArray addObject:[[NSMutableArray alloc] init]];
    }
    
    allEvents = [Evento loadEvents];
    [self sortEventsByDay];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    for (Evento *event in allEvents) {
        NSDateComponents* components = [calendar components:NSCalendarUnitMonth fromDate:event.date]; // Get necessary date components
        
        
        [monthArray[[components month]-1] addObject:event];
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [tabelacalendario count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([monthArray[section] count] == 0)
        return nil;
    return [tabelacalendario objectAtIndex:section]; //imprimir titulo no cabeçalho
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [monthArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    eventTableViewCell *cell = (eventTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    //if (cell == nil) {
    //    cell = [[eventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    //}
    
    Evento *e = [monthArray[indexPath.section] objectAtIndex:indexPath.row];
    //cell.textLabel.text = e.nomeEvento;
    cell.labelEventName.text = e.nomeEvento;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle: NSDateFormatterShortStyle];
    [formatter setDateFormat: @"dd"];
    NSString *eventDay = [formatter stringFromDate:e.date];
    cell.labelEventDay.text = eventDay;
    
    NSDateFormatter *formatterWeekDay = [[NSDateFormatter alloc] init];
    [formatterWeekDay setDateStyle: NSDateFormatterShortStyle];
    [formatterWeekDay setDateFormat: @"EE"];
    NSString *eventWeekDay = [formatterWeekDay stringFromDate:e.date];
    cell.labelEventWeekDay.text = eventWeekDay;
    
    //[tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    cell.event = [monthArray[indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([monthArray[section] count] == 0)
        return 0.01f;
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backFromRegisterEventScreen:(UIStoryboardSegue *)sender {
    [self loadEvents];
    [_TabelaCalendario reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(eventTableViewCell *)sender{
    if ([segue.identifier isEqualToString:@"segueDetailEvent"]) {
        DetailEventViewController *detail = (DetailEventViewController *)segue.destinationViewController;

        detail.ev = sender.event;
    }
}

- (IBAction)clickAddButton:(id)sender {
    FXFormViewController *controller = [[FXFormViewController alloc] init];
    controller.formController.form = [[Evento alloc] init];
    
    _navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
    controller.navigationItem.title = @"Dados do Evento";
    controller.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Salvar" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    
    [self presentViewController:_navController animated:YES completion:nil];
}

- (void)dismiss:(id)sender {
    [_navController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)save:(id)sender {
    FXFormViewController *formQueVoltou = (FXFormViewController*)_navController.topViewController;
    _event = formQueVoltou.formController.form;
    
    if ([self emptyFieldDoesExist] == NO){
        [_event save];
        [_navController dismissViewControllerAnimated:NO completion:^{
            UIAlertView *alertEventCreated = [[UIAlertView alloc] initWithTitle:@"Evento criado" message:@"Novo evento criado com sucesso!" delegate: self cancelButtonTitle:@"OK"otherButtonTitles: nil];
            [alertEventCreated show];
        }];
    }
}

- (BOOL) emptyFieldDoesExist{
    if (_event.nomeEvento == nil ||
        _event.endereco == nil ||
        _event.date == nil ||
        _event.descricao == nil)
    {
        UIAlertView *alertEmptyFields = [[UIAlertView alloc] initWithTitle:@"Campos incompletos" message:@"Por favor, preencha todos os campos." delegate: self cancelButtonTitle:@"OK"otherButtonTitles: nil];
        [alertEmptyFields show];
        return YES;
    }
    return NO;
}

@end
