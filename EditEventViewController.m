//
//  EditEventViewController.m
//  EventKitDemo
//
//  Created by Gabriel Theodoropoulos on 11/7/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "EditEventViewController.h"
#import "AppDelegate.h"


@interface EditEventViewController ()

@property (nonatomic, strong) AppDelegate *appDelegate;

@property (nonatomic, strong) NSString *eventTitle;

@property (nonatomic, strong) NSDate *eventStartDate;

@property (nonatomic, strong) NSDate *eventEndDate;

@property (nonatomic, strong) EKEvent *editedEvent;

@property (nonatomic, strong) NSMutableArray *arrAlarms;

@property (nonatomic, strong) NSArray *arrRepeatOptions;

@property (nonatomic) NSUInteger indexOfSelectedRepeatOption;

@property (nonatomic) NSString *name;




-(void)determineIndexOfRepeatOption;

@end


@implementation EditEventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Title Of ViewController
    self.navigationItem.title = @"Add Alarm";
    
    
    // Instantiate the appDelegate property, so we can access its eventManager property.
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Make self the delegate and datasource of the table view.
    self.tblEvent.delegate = self;
    self.tblEvent.dataSource = self;
    
    
    // Set initial values.
    self.eventStartDate = nil;
    self.eventEndDate = nil;
    self.arrAlarms = [[NSMutableArray alloc] init];
    
    
    // Initialize the repeat options array.
    self.arrRepeatOptions = @[@"Never", @"Always", @"Every 3 days", @"Every week", @"Every 2 weeks", @"Every month", @"Every six months", @"Every year"];
    
    self.indexOfSelectedRepeatOption = 0;
    
    
    // Check the value of the selectedEventIdentifier property, of the eventManager object.
    // If its length is 0, then a new event is going to be added.
    // If its length is other than 0, then an existing event is going to be edited. In that case, load the event.
    if (self.appDelegate.eventManager.selectedEventIdentifier.length > 0) {
        self.editedEvent = [self.appDelegate.eventManager.eventStore eventWithIdentifier:self.appDelegate.eventManager.selectedEventIdentifier];
        
        self.eventTitle = self.editedEvent.title;
        self.eventStartDate = self.editedEvent.startDate;
        self.eventEndDate = self.editedEvent.endDate;
        
        
        // Determine the index of the repeat option based on the recurrence rule of the edited event.
        [self determineIndexOfRepeatOption];
        
        
        // If there are alarms, then keep the absolute date of each one.
        if (self.editedEvent.hasAlarms) {
            NSArray *alarms = self.editedEvent.alarms;
            for (int i=0; i<alarms.count; i++) {
                [self.arrAlarms addObject:[(EKAlarm *)[alarms objectAtIndex:i] absoluteDate]];
            }
        }
    }
    //ziéda
    _eventTitle = _name;
    NSLog(@"%@",_eventTitle);
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"drugreminder.sqlite"];
    
    
       [self Drug];
}
//ziéda


-(void)Drug{
    // Form the query.
    NSString *query = [NSString stringWithFormat:@"select * from drug where id_drug=%@",_iddrugal];
    NSLog(@"%@",query);
    
    // Get the results.
    if (self.arrdrugs != nil) {
        self.arrdrugs = nil;
    }
    self.arrdrugs = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
   
    
    _name = [[self.arrdrugs objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"name"]];
    
    NSLog(@"edit alram is: %@",_name);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"idSegueDatepicker"]) {
        DatePickerViewController *datePickerViewController = [segue destinationViewController];
        datePickerViewController.delegate = self;
    }
}


#pragma mark - UITableView Delegate and Datasource method implementation

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    else{
       return self.arrRepeatOptions.count;
    }
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Planning informations";
    }
    else{
        return @"Reminder";
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        // If the cell is nil, then dequeue it. Make sure to dequeue the proper cell based on the row.
        if (cell == nil) {
            if (indexPath.row == 0) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"idCellTitle"];
            }
            else{
                cell = [tableView dequeueReusableCellWithIdentifier:@"idCellGeneral"];
            }
        }
        
        
        switch (indexPath.row) {
            case 0:
                // The title of the event.
            {
                UILabel *titleTextfield = (UILabel *)[cell.contentView viewWithTag:100];
                titleTextfield.text=@"testlabel";
                
                //titleTextfield.delegate = self;
                titleTextfield.text = self.eventTitle;
            }
                break;
                
            case 1:
                // The event start date.
                if (self.eventStartDate == nil) {
                    cell.textLabel.text = @"Start date";
                }
                else{
                    cell.textLabel.text = [self.appDelegate.eventManager getStringFromDate:self.eventStartDate];
                }
                break;
                
            case 2:
                // The event end date.
                if (self.eventEndDate == nil) {
                    cell.textLabel.text = @"End date";
                }
                else{
                    cell.textLabel.text = [self.appDelegate.eventManager getStringFromDate:self.eventEndDate];
                }
                break;
                
            default:
                break;
        }
    }

    else{
        if (cell == nil) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"idCellGeneral"];
        }
        
        // The section with the repeat options.
        cell.textLabel.text = [self.arrRepeatOptions objectAtIndex:indexPath.row];
        
        if (indexPath.row == self.indexOfSelectedRepeatOption) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 2)) ||
        (indexPath.section == 1 && indexPath.row == 0)) {
        [self performSegueWithIdentifier:@"idSegueDatepicker" sender:self];
    }
    
    if (indexPath.section == 1) {
        self.indexOfSelectedRepeatOption = indexPath.row;
        
        [self.tblEvent reloadData];
    }
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row > 0) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            // Remove the respective date from the arrAlarms array.
            [self.arrAlarms removeObjectAtIndex:indexPath.row - 1];
            
            // Reload the table view.
            [self.tblEvent reloadData];
        }
    }
}


#pragma mark - IBAction method implementation

- (IBAction)saveEvent:(id)sender {
    
    //Declaration Of Alert
    UIAlertView *alertDateVerification = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"The date field is invalid" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    UIAlertView *alertDescriptionVerification = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"Drug's name is empty!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    UIAlertView *alerEmptyDateVerification = [[UIAlertView alloc] initWithTitle:@"Erreur" message:@"The date field is empty!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    self.eventTitle = _name;
    
    // Check if a title was typed in for the event.
    if (self.eventTitle.length == 0) {
        // In this case, just do nothing.
        [alertDescriptionVerification show];
        return;
    }
    
    // Check if a start and an end date was selected for the event.
    if (self.eventStartDate == nil || self.eventEndDate == nil) {
        // In this case, do nothing too.
        [alerEmptyDateVerification show];
        return;
    }
    
    if (self.appDelegate.eventManager.selectedEventIdentifier.length > 0) {
        [self.appDelegate.eventManager deleteEventWithIdentifier:self.appDelegate.eventManager.selectedEventIdentifier];
        self.appDelegate.eventManager.selectedEventIdentifier = @"";
    }
    
    // Create a new event object.
    EKEvent *event = [EKEvent eventWithEventStore:self.appDelegate.eventManager.eventStore];
    
    // Set the event title.
    event.title = self.eventTitle;
    
    //Set The Default Calendar
    EKEventStore *eventstore = [[EKEventStore alloc] init];
    [event setCalendar:[eventstore defaultCalendarForNewEvents]];
    
    // Set its calendar.
    /*event.calendar = [self.appDelegate.eventManager.eventStore calendarWithIdentifier:self.appDelegate.eventManager.selectedCalendarIdentifier];*/
    
    
    // Set the start and end dates to the event.
    event.startDate = self.eventStartDate;
    event.endDate = self.eventEndDate;
    
    //Verification If The start date must be before the end date.
    if(event.startDate > event.endDate){
        [alertDateVerification show];
    }
    
    // Add Alarm .
    NSDate *alarmDate = event.startDate;
    EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:alarmDate];
    [event addAlarm:alarm];
    
    
    // Specify the recurrence frequency and interval values based on the respective selected option.
    EKRecurrenceFrequency frequency;
    NSInteger interval;
    switch (self.indexOfSelectedRepeatOption) {
        case 1:
            frequency = EKRecurrenceFrequencyDaily;
            interval = 1;
            break;
        case 2:
            frequency = EKRecurrenceFrequencyDaily;
            interval = 3;
        case 3:
            frequency = EKRecurrenceFrequencyWeekly;
            interval = 1;
        case 4:
            frequency = EKRecurrenceFrequencyWeekly;
            interval = 2;
        case 5:
            frequency = EKRecurrenceFrequencyMonthly;
            interval = 1;
        case 6:
            frequency = EKRecurrenceFrequencyMonthly;
            interval = 6;
        case 7:
            frequency = EKRecurrenceFrequencyYearly;
            interval = 1;
            
        default:
            interval = 0;
            frequency = EKRecurrenceFrequencyDaily;
            break;
            
    }
    
    // Create a rule and assign it to the reminder object if the interval is greater than 0.
    if (interval > 0) {
        EKRecurrenceEnd *recurrenceEnd = [EKRecurrenceEnd recurrenceEndWithEndDate:event.endDate];
        EKRecurrenceRule *rule = [[EKRecurrenceRule alloc] initRecurrenceWithFrequency:frequency interval:interval end:recurrenceEnd];
        event.recurrenceRules = @[rule];
    }
    else{
        event.recurrenceRules = nil;
    }
    
    // Save and commit the event.
    NSError *error;
    if ([self.appDelegate.eventManager.eventStore saveEvent:event span:EKSpanFutureEvents commit:YES error:&error]) {
        // Call the delegate method to notify the caller class (the ViewController class) that the event was saved.
        [self.delegate eventWasSuccessfullySaved];
        
        // Pop the current view controller from the navigation stack.
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        // An error occurred, so log the error description.
        NSLog(@"%@", [error localizedDescription]);
    }
}


#pragma mark - UITextFieldDelegate method implementation

/*-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.eventTitle = textField.text;
    [textField resignFirstResponder];
    
    return YES;
}*/
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - DatePickerViewControllerDelegate method implementation

-(void)dateWasSelected:(NSDate *)selectedDate{
    // Based on the selected cell, specify what the selected date is purposed for.
    NSIndexPath *indexPath = [self.tblEvent indexPathForSelectedRow];
    
    if (indexPath.section == 0) {
        // In this case, it's either the event start or end date.
        if (indexPath.row == 1) {
            // The event start date.
            self.eventStartDate = selectedDate;
        }
        else{
            // The event end date.
            self.eventEndDate = selectedDate;
        }
    }
    else{
        // In this case, the selected date regards a new alarm.
        [self.arrAlarms addObject:selectedDate];
    }
    
    // Reload the table view.
    [self.tblEvent reloadData];
}


#pragma mark - Private method implementation

-(void)determineIndexOfRepeatOption{
    if (self.editedEvent.recurrenceRules != nil && self.editedEvent.recurrenceRules.count > 0) {
        // Get the frequency and interval values from the recurrence rule of the edited event.
        EKRecurrenceRule *rule = [self.editedEvent.recurrenceRules objectAtIndex:0];
        
        EKRecurrenceFrequency frequency = rule.frequency;
        NSInteger interval = rule.interval;
        
        if (interval == 1){
            if (frequency == EKRecurrenceFrequencyDaily) {
                self.indexOfSelectedRepeatOption = 1;
            }
            else if (frequency == EKRecurrenceFrequencyWeekly){
                self.indexOfSelectedRepeatOption = 3;
            }
            else if (frequency == EKRecurrenceFrequencyMonthly){
                self.indexOfSelectedRepeatOption = 5;
            }
            else{
                self.indexOfSelectedRepeatOption = 7;
            }
        }
        else{
            if (frequency == EKRecurrenceFrequencyDaily) {
                self.indexOfSelectedRepeatOption = 2;
            }
            else if (frequency == EKRecurrenceFrequencyWeekly){
                self.indexOfSelectedRepeatOption = 4;
            }
            else{
                self.indexOfSelectedRepeatOption = 6;
            }
        }
    }
}

@end
