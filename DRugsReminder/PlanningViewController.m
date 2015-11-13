//
//  PlanningViewController.m
//  TrackMe
//
//  Created by Trabelsi Achraf on 2/19/15.
//  Copyright (c) 2015 ESPRIT. All rights reserved.
//

#import "PlanningViewController.h"
#import "AppDelegate.h"


@interface PlanningViewController ()

@property (nonatomic, strong) AppDelegate *appDelegate;

@property (nonatomic, strong) NSArray *arrEvents;
@property (nonatomic, strong) NSMutableArray *arrEventsnew;
@property (nonatomic, strong) NSArray *arrCalendars;
@property (nonatomic, strong) NSString *name;

-(void)requestAccessToEvents;

-(void)loadEvents;

@end

@implementation PlanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Title Of ViewController
    self.navigationItem.title = @"Alarms";
    
    // Instantiate the appDelegate property.
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Make self the delegate and datasource of the table view.
    self.tblEvents.delegate = self;
    self.tblEvents.dataSource = self;
    
    
    // Request access to events.
    [self performSelector:@selector(requestAccessToEvents) withObject:nil afterDelay:0];
    
    // Load the events with a small delay, so the store event gets ready.
    [self performSelector:@selector(loadEvents) withObject:nil afterDelay:0];
    
    //ziéda
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"drugreminder.sqlite"];
    

    NSLog(@"%@",_iddrug);
    [self Drug];
  
    
}
//Ziéda Méthode recuperation id drug parametre
-(void)Drug{
    // Form the query.
    NSString *query = [NSString stringWithFormat:@"select * from drug where id_drug=%@",_iddrug];
    NSLog(@"%@",query);
    
    // Get the results.
    if (self.arrdrugs != nil) {
        self.arrdrugs = nil;
    }
    self.arrdrugs = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"%@", @"yahoo");
  
     _name = [[self.arrdrugs objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"name"]];
    
   NSLog(@"lowerCaseString is: %@",_name);
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"idSegueEvent"]) {
        EditEventViewController *editEventViewController = [segue destinationViewController];
        editEventViewController.iddrugal = _iddrug;
        editEventViewController.delegate = self;
    }
}

- (IBAction)barButton:(id)sender {
}



#pragma mark - UITableView Delegate and Datasource method implementation

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrEventsnew.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellEvent"];
    
    // Get each single event.
    EKEvent *event = [self.arrEventsnew objectAtIndex:indexPath.row];
    
    
    // Set its title to the cell's text label.
    cell.textLabel.text = event.title;
    
    // Get the event start date as a string value.
    NSString *startDateString = [self.appDelegate.eventManager getStringFromDate:event.startDate];
    
    // Get the event end date as a string value.
    NSString *endDateString = [self.appDelegate.eventManager getStringFromDate:event.endDate];
    
    // Add the start and end date strings to the detail text label.
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", startDateString, endDateString];
    
    return cell;
  
        
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    // Keep the identifier of the event that's about to be edited.
    self.appDelegate.eventManager.selectedEventIdentifier = [[self.arrEventsnew objectAtIndex:indexPath.row] eventIdentifier];
    
    // Perform the segue.
    [self performSegueWithIdentifier:@"idSegueEvent" sender:self];
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the selected event.
        [self.appDelegate.eventManager deleteEventWithIdentifier:[[self.arrEventsnew objectAtIndex:indexPath.row] eventIdentifier]];
        
        // Reload all events and the table view.
        [self loadEvents];
    }
}


#pragma mark - EditEventViewControllerDelegate method implementation

-(void)eventWasSuccessfullySaved{
    // Reload all events.
    [self loadEvents];
}


#pragma mark - IBAction method implementation

- (IBAction)showCalendars:(id)sender {
    if (self.appDelegate.eventManager.eventsAccessGranted) {
        [self performSegueWithIdentifier:@"idSegueCalendars" sender:self];
    }
}


- (IBAction)createEvent:(id)sender {
    if (self.appDelegate.eventManager.eventsAccessGranted) {
        [self performSegueWithIdentifier:@"idSegueEvent" sender:self];
    }
}


#pragma mark - Private method implementation

-(void)requestAccessToEvents{
    [self.appDelegate.eventManager.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (error == nil) {
            // Store the returned granted value.
            self.appDelegate.eventManager.eventsAccessGranted = granted;
        }
        else{
            // In case of error, just log its description to the debugger.
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}


-(void)loadEvents{
    if (self.appDelegate.eventManager.eventsAccessGranted) {
        self.arrEvents = [self.appDelegate.eventManager getEventsOfSelectedCalendar];
        NSLog(@"for nom %@", _name);
        _arrEventsnew  = [NSMutableArray new];

        for (EKEvent * item in _arrEvents) {
            
            if([item.title isEqualToString: _name]){
                
                NSLog(@"for titre %@ %@", item.title, _name);
                [_arrEventsnew addObject:item];
            }
            NSLog(@"%lu",(unsigned long)_arrEventsnew.count);
        }
        [self.tblEvents reloadData];
    }
}


@end
