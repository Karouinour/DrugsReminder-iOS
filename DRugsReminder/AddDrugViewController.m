//
//  AddDrugViewController.m
//  DRugsReminder
//
//  Created by DrugsReminder on 17/04/2015.
//  Copyright (c) 2015 DrugsReminder. All rights reserved.
//

#import "AddDrugViewController.h"
#import "ListDrugsViewController.h"
#import "DBManager.h"



@interface AddDrugViewController ()

@property (nonatomic, strong) DBManager *dbManager;

-(void)loadInfoToEdit;

@end


@implementation AddDrugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Make self the delegate of the textfields.
    self.txtname.delegate = self;
    
       // Set the navigation bar tint color.
    
    
    self.navigationController.navigationBar.tintColor = self.navigationItem.rightBarButtonItem.tintColor;
    
    // Initialize the dbManager object.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"drugreminder.sqlite"];
    
    // Check if should load specific record for editing.
    if (self.recordIDToEditDrug != -1) {
        // Load the record with the specific ID from the database.
        [self loadInfoToEdit];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (IBAction)btn_vial:(id)sender {
    [_btn_vial setAlpha: 1];
    [_btn_Syrup setAlpha: 0.2];
    [_btn_injection setAlpha: 0.2];
    [_btn_pill setAlpha: 0.2];
    [_btn_pomade setAlpha: 0.2];
    _icone = @"vial";

}
- (IBAction)btn_Syrup:(id)sender {
    [_btn_vial setAlpha: 0.2];
    [_btn_Syrup setAlpha: 1];
    [_btn_injection setAlpha: 0.2];
    [_btn_pill setAlpha: 0.2];
    [_btn_pomade setAlpha: 0.2];
    _icone = @"syrup";
}
- (IBAction)btn_injection:(id)sender {
    [_btn_vial setAlpha: 0.2];
    [_btn_Syrup setAlpha: 0.2];
    [_btn_injection setAlpha: 1];
    [_btn_pill setAlpha: 0.2];
    [_btn_pomade setAlpha: 0.2];
    _icone = @"injection";
}
- (IBAction)btn_pill:(id)sender {
    [_btn_vial setAlpha: 0.2];
    [_btn_Syrup setAlpha: 0.2];
    [_btn_injection setAlpha: 0.2];
    [_btn_pill setAlpha: 1];
    [_btn_pomade setAlpha: 0.2];
    _icone = @"pill";
    
}
- (IBAction)btn_pomade:(id)sender {
    [_btn_vial setAlpha: 0.2];
    [_btn_Syrup setAlpha: 0.2];
    [_btn_injection setAlpha: 0.2];
    [_btn_pill setAlpha: 0.2];
    [_btn_pomade setAlpha: 1];
    _icone = @"pommade";
}






-(void)loadInfoToEdit{
    // Create the query.
    NSString *query = [NSString stringWithFormat:@"select * from drug where id_drug=%d", self.recordIDToEditDrug];
    
    // Load the relevant data.
    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Set the loaded data to the textfields.
   // NSString * icone =[[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"icone"]];
    
    _icone =[[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"icone"]];
    
    if ([_icone  isEqual: @"pommade"]) {
        [_btn_pomade setAlpha: 1];
    }
    
    if ([_icone  isEqual: @"pill"]) {
        [_btn_pill setAlpha: 1];
    }
    
    if ([_icone  isEqual: @"injection"]) {
        [_btn_injection setAlpha: 1];
    }
    
    if ([_icone  isEqual: @"syrup"]) {
        [_btn_Syrup setAlpha: 1];
    }
    
    if ([_icone  isEqual: @"vial"]) {
        [_btn_vial setAlpha: 1];
    }

    
    self.idUser =[[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"id_user"]];
    
    self.txtname.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"name"]];
    
    
}


- (IBAction)savedrug:(id)sender {
    if([_txtname.text  isEqual: @""]){
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Invalid drug name"
                                                           message:@"Please select drug Name"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        [theAlert show];
    }else{

    
    NSLog(@"%@",_idUser);
    
    NSString *query;
    if (self.recordIDToEditDrug == -1) {
        query = [NSString stringWithFormat:@"insert into drug values (null, %@, '%@', '%@')",self.idUser, self.txtname.text, self.icone];
        NSLog(@"%@",query);
        ListDrugsViewController * svc = [self.storyboard instantiateViewControllerWithIdentifier:@"ListDrugsViewController"];
        svc.ID2 =self.idUser;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"%@",query);
        query = [NSString stringWithFormat:@"update drug set name='%@', icone='%@' where id_drug=%d", self.txtname.text, self.icone,self.recordIDToEditDrug];
        ListDrugsViewController * svc = [self.storyboard instantiateViewControllerWithIdentifier:@"ListDrugsViewController"];
        svc.ID2 =self.idUser;
        [self.navigationController popViewControllerAnimated:YES];

    }
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Inform the delegate that the editing was finished.
        [self.delegateDrug editingInfoWasFinished];
        
        // Pop the view controller.
               [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"Could not execute the query.");
    }
        }

    }


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end

