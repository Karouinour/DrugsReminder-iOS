#import "ListUsersViewController.h"
#import "DBManager.h"
#import "ListDrugsViewController.h"
#import "Celluser.h"


@interface ListUsersViewController ()

@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrPeopleInfo;

@property (nonatomic) int recordIDToEdit;


-(void)loadData;

@end

@implementation ListUsersViewController

- (IBAction)pushViewController:(id)sender
{
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = @"Pushed Controller";
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
}

    //*************************************************************

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.navigationItem.title = @"Users";
    // Do any additional setup after loading the view, typically from a nib.
    
    // Make self the delegate and datasource of the table view.
    self.tblPeople.delegate = self;
    self.tblPeople.dataSource = self;
    
    // Initialize the dbManager property.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"drugreminder.sqlite"];
   // self.navigationController.navigationBar.barTintColor = [UIColor ];
    // Load the data.
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier]isEqualToString:@"to_drugs"]){
        NSIndexPath * indexpath = [self.tblPeople indexPathForSelectedRow];
        NSArray * PplList = _arrPeopleInfo;
        NSLog(@"hello list drug");
        NSArray * string = [PplList objectAtIndex:indexpath.row];
        [[segue destinationViewController] setID2:string[0]];
        
    }
    else{
    EditUserViewController *editUserViewController = [segue destinationViewController];
    editUserViewController.delegate = self;
    editUserViewController.recordIDToEdit = self.recordIDToEdit;
         }
}


#pragma mark - IBAction method implementation

- (IBAction)addNewRecord:(id)sender {
    // Before performing the segue, set the -1 value to the recordIDToEdit. That way we'll indicate that we want to add a new record and not to edit an existing one.
    self.recordIDToEdit = -1;
    
    // Perform the segue.
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}

- (IBAction)home:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:(YES)];
}


#pragma mark - Private method implementation

-(void)loadData{
    // Form the query.
    NSString *query = @"select * from user";
    
    // Get the results.
    if (self.arrPeopleInfo != nil) {
        self.arrPeopleInfo = nil;
    }
    self.arrPeopleInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    [self.tblPeople reloadData];
}


#pragma mark - UITableView method implementation

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrPeopleInfo.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Dequeue the cell.
    Celluser *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    
    NSInteger indexOfname = [self.dbManager.arrColumnNames indexOfObject:@"name"];
    NSInteger indexOfemail = [self.dbManager.arrColumnNames indexOfObject:@"email"];
    //NSInteger indexOfphone = [self.dbManager.arrColumnNames indexOfObject:@"phone"];
    NSInteger indexOficone = [self.dbManager.arrColumnNames indexOfObject:@"icone"];
    
    // Set the loaded data to the appropriate cell labels.
    

    cell.username.textColor = [UIColor colorWithRed:0 green:0.588 blue:0.533 alpha:1] ;/*#009688*/
    
    cell.username.text = [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfname];

     cell.emil.text = [NSString stringWithFormat:@"%@", [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfemail]];

    
    //cell.tel.text = [NSString stringWithFormat:@"%@", [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfphone]];
    
      // cell.imageView.frame = CGRectMake(0, 0 , 10, 10);
    cell.userimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOficone]]];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    // Get the record ID of the selected name and set it to the recordIDToEdit property.
    self.recordIDToEdit = [[[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    
    // Perform the segue.
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the selected record.
        // Find the record ID.
        int recordIDToDelete = [[[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
        
        // Prepare the query.
        NSString *query = [NSString stringWithFormat:@"delete from user where id_user=%d", recordIDToDelete];
        
        // Execute the query.
        [self.dbManager executeQuery:query];
        
        // Reload the table view.
        [self loadData];
    }
}


#pragma mark - EditInfoViewControllerDelegate method implementation

-(void)editingInfoWasFinished{
    // Reload the data.
    [self loadData];
}


    //*************************************************************

@end
