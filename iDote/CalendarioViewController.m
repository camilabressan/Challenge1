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
    
}

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
    
    monthArray = [[NSMutableArray alloc] init];
    for (int i = 0; i< tabelacalendario.count; i++) {
        [monthArray addObject:[[NSMutableArray alloc] init]];
    }
    
    allEvents = [Evento loadEvents];
    
    
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
    return [tabelacalendario objectAtIndex:section]; //imprimir titulo no cabeçalho
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [monthArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *simpleTableIdentifier = @"eventCell";
    
    eventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[eventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
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
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backFromRegisterEventScreen:(UIStoryboardSegue *)sender {

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
