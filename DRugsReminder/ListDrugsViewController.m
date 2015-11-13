//
//  ListDrugs.m
//  DRugsReminder
//
//  Created by KarouiNoour on 3/5/15.
//  Copyright (c) 2015 DrugsReminder. All rights reserved.
//

#import "ListDrugsViewController.h"
#import "AddDrugViewController.h"
#import "PlanningViewController.h"
#import "DBManager.h"
#import "Celldrug.h"


@interface ListDrugsViewController ()
@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrdrugs;

@property (nonatomic) int recordIDToEditDrug;


@end

@implementation ListDrugsViewController


- (IBAction)pushViewController:(id)sender
{
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = @"Pushed Controller";
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabledrugs.delegate = self;
    self.tabledrugs.dataSource = self;
    //NSLog(@"%@",_ID2);
    // Initialize the dbManager property.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"drugreminder.sqlite"];
    
    // Load the data.
    [self loadData];

}

-(void)loadData{
    // Form the query.
    NSString *query = [NSString stringWithFormat:@"select * from drug where id_user=%@",_ID2];
    NSLog(@"%@",query);
    
    // Get the results.
    if (self.arrdrugs != nil) {
        self.arrdrugs = nil;
    }
    self.arrdrugs = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    [self.tabledrugs reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
   if ([[segue identifier]isEqualToString:@"to_Alarm"]){
       NSIndexPath * indexpath = [self.tabledrugs indexPathForSelectedRow];
       NSArray * PplList = _arrdrugs;
       NSLog(@"hello list Alarm");
       NSArray * string = [PplList objectAtIndex:indexpath.row];
       [[segue destinationViewController] setIddrug:string[0]];
       
       
  }
   else{
        AddDrugViewController  *adddrugViewController = [segue destinationViewController];
        //adddrugViewController.delegateDrug = self;
        adddrugViewController.idUser = _ID2;
        adddrugViewController.recordIDToEditDrug = self.recordIDToEditDrug;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
// Ajouter un nouveau medicament
#pragma mark - IBAction method implementation
- (IBAction)addnewdrug:(id)sender {
    // Before performing the segue, set the -1 value to the recordIDToEdit. That way we'll indicate that we want to add a new record and not to edit an existing one.
    self.recordIDToEditDrug = -1;
    
    // Perform the segue.
    [self performSegueWithIdentifier:@"idSeguedrug" sender:self];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrdrugs.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Dequeue the cell.
    Celldrug *cell = [tableView dequeueReusableCellWithIdentifier:@"celldrug" forIndexPath:indexPath];
    

    //recuperation du arr
    NSInteger indexOfname = [self.dbManager.arrColumnNames indexOfObject:@"name"];
    NSInteger indexOficone = [self.dbManager.arrColumnNames indexOfObject:@"icone"];

   cell.drugName.text = [NSString stringWithFormat:@"%@", [[self.arrdrugs objectAtIndex:indexPath.row] objectAtIndex:indexOfname]];
    
    cell.imgdrug.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[[self.arrdrugs objectAtIndex:indexPath.row] objectAtIndex:indexOficone]]];
    
    return cell;
}




-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    // Get the record ID of the selected name and set it to the recordIDToEditDrug property.
    self.recordIDToEditDrug = [[[self.arrdrugs objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    
    // Perform the segue.
    [self performSegueWithIdentifier:@"idSeguedrug" sender:self];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the selected record.
        // Find the record ID.
        int recordIDToDelete = [[[self.arrdrugs objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
        
        // Prepare the query.
        NSString *query = [NSString stringWithFormat:@"delete from drug where id_drug=%d", recordIDToDelete];
        
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







@end
