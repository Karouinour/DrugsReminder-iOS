#import "EditUserViewController.h"
#import "DBManager.h"
#import "ListUsersViewController.h"


@interface EditUserViewController ()

@property (nonatomic, strong) DBManager *dbManager;

-(void)loadInfoToEdit;

@end


@implementation EditUserViewController

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
    // Do any additional setup after loading the view.
    
    // Make self the delegate of the textfields.
    self.txtname.delegate = self;
    self.txtemail.delegate = self;
    self.txtphone.delegate = self;
    self.persone.hidden=YES;
    self.petview.hidden=YES;
   // self.back.enabled=NO;
    // Set the navigation bar tint color.
    self.navigationController.navigationBar.tintColor = self.navigationItem.rightBarButtonItem.tintColor;
    
    // Initialize the dbManager object.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"drugreminder.sqlite"];
    
    // Check if should load specific record for editing.
    if (self.recordIDToEdit != -1) {
        // Load the record with the specific ID from the database.
        [self loadInfoToEdit];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UITextFieldDelegate method implementation

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - IBAction method implementation

- (IBAction)btn_homme:(id)sender {
    if([_txtname.text  isEqual: @""]){
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Invalid name"
                                                           message:@"Please select Name"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        [theAlert show];
    }else{
    [_btn_femme setAlpha: 0.2];
    [_btn_homme setAlpha: 1];
    [_btn_pet setAlpha: 0.2];
 //   self.back.enabled=YES;
    self.Primview.hidden=YES;
    self.persone.hidden=NO;
    self.petview.hidden=YES;
    _txticone =@"homme";
   }
}

- (IBAction)btn_femme:(id)sender {
    if([_txtname.text  isEqual: @""]){
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Invalid name"
                                                           message:@"Please select Name"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        [theAlert show];
    }else{

    [_btn_femme setAlpha: 1];
    [_btn_homme setAlpha: 0.2];
    [_btn_pet setAlpha: 0.2];
    
  //  self.back.enabled=YES;
    self.Primview.hidden=YES;
    self.persone.hidden=NO;
    self.petview.hidden=YES;
    _txticone =@"femme";
        }

}

- (IBAction)btn_pet:(id)sender {
    if([_txtname.text  isEqual: @""]){
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Invalid name"
                                                           message:@"Please select Name"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        [theAlert show];
    }else{

    [_btn_femme setAlpha: 0.2];
    [_btn_homme setAlpha: 0.2];
    [_btn_pet setAlpha: 1];
    //self.back.enabled=YES;
    self.Primview.hidden=YES;
    self.persone.hidden=YES;
    self.petview.hidden=NO;
    _txticone =@"cat";
      }
}

- (IBAction)btn_cat_pet:(id)sender {
    [_btn_cat_pet setAlpha: 1];
    [_btn_horse_pet setAlpha: 0.2];
    [_btn_dog_pet setAlpha: 0.2];
    [_btn_rabbit_pet setAlpha: 0.2];
    [_btn_bird_pet setAlpha: 0.2];
    _txticone =@"cat";
    _txtemail.text = @"";
    _txtphone.text = @"";
    
}

- (IBAction)btn_horse_pet:(id)sender {
    [_btn_cat_pet setAlpha: 0.2];
    [_btn_horse_pet setAlpha: 1];
    [_btn_dog_pet setAlpha: 0.2];
    [_btn_rabbit_pet setAlpha: 0.2];
    [_btn_bird_pet setAlpha: 0.2];
    _txticone =@"horse";
    _txtemail.text = @"";
    _txtphone.text = @"";
}

- (IBAction)btn_dog_pet:(id)sender {
    [_btn_cat_pet setAlpha: 0.2];
    [_btn_horse_pet setAlpha: 0.2];
    [_btn_dog_pet setAlpha: 1];
    [_btn_rabbit_pet setAlpha: 0.2];
    [_btn_bird_pet setAlpha: 0.2];
    _txticone =@"dog";
    _txtemail.text = @"";
    _txtphone.text = @"";
}

- (IBAction)btn_rabbit_pet:(id)sender {
    [_btn_cat_pet setAlpha: 0.2];
    [_btn_horse_pet setAlpha: 0.2];
    [_btn_dog_pet setAlpha: 0.2];
    [_btn_rabbit_pet setAlpha: 1];
    [_btn_bird_pet setAlpha: 0.2];
    _txticone =@"rabbit";
    _txtemail.text = @"";
    _txtphone.text = @"";
}

- (IBAction)btn_bird_pet:(id)sender {
    [_btn_cat_pet setAlpha: 0.2];
    [_btn_horse_pet setAlpha: 0.2];
    [_btn_dog_pet setAlpha: 0.2];
    [_btn_rabbit_pet setAlpha: 0.2];
    [_btn_bird_pet setAlpha: 1];
    _txticone =@"bird";
    _txtemail.text = @"";
    _txtphone.text = @"";
}

/*- (IBAction)back:(id)sender {
  //  self.back.enabled=NO;
    self.persone.hidden=YES;
    self.petview.hidden=YES;
    self.Primview.hidden=NO;

}*/



- (IBAction)saveInfo:(id)sender {
    // Prepare the query string.
    // If the recordIDToEdit property has value other than -1, then create an update query. Otherwise create an insert query.
    NSString *query;
    if (self.recordIDToEdit == -1) {
        query = [NSString stringWithFormat:@"insert into user values(null, '%@', '%@', '%@','%@')",self.txtname.text, self.txtemail.text, self.txtphone.text, self.txticone];
       // ListUsersViewController * svc = [self.storyboard instantiateViewControllerWithIdentifier:@"ListUsersViewController"];
        //[self.navigationController pushViewController:svc animated:YES];
        [self.navigationController popViewControllerAnimated:YES];

            }
    else{
        query = [NSString stringWithFormat:@"update user set name='%@', email='%@', phone='%@',icone='%@' where user_id=%d", _txtname.text, _txtemail.text, _txtphone.text, _txticone, self.recordIDToEdit];
       // ListUsersViewController * svc = [self.storyboard instantiateViewControllerWithIdentifier:@"ListUsersViewController"];
       // [self.navigationController pushViewController:svc animated:YES];
        [self.navigationController popViewControllerAnimated:YES];

    }
    
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Inform the delegate that the editing was finished.
        [self.delegate editingInfoWasFinished];
        
        // Pop the view controller.
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"Could not execute the query.");
    }
}


#pragma mark - Private method implementation

-(void)loadInfoToEdit{
    // Create the query.
    NSString *query = [NSString stringWithFormat:@"select * from user where id_user=%d", self.recordIDToEdit];
    
    // Load the relevant data.
    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Set the loaded data to the textfields.
    NSString * icone =[[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"icone"]];
    if ([icone  isEqual: @"homme"]) {
        [_btn_homme setAlpha:1];
    }
    if ([icone  isEqual: @"femme"]) {
        [_btn_femme setAlpha:1];
    }
    if ([icone  isEqual: @"dog"]) {
        [_btn_pet setAlpha:1];
        [_btn_dog_pet setAlpha:1];
        
    }
    if ([icone  isEqual: @"cat"]) {
        [_btn_pet setAlpha:1];
        [_btn_cat_pet setAlpha:1];
        
    }
    if ([icone  isEqual: @"horse"]) {
        [_btn_pet setAlpha:1];
        [_btn_horse_pet setAlpha:1];
        
    }
    if ([icone  isEqual: @"rabbit"]) {
        [_btn_pet setAlpha:1];
        [_btn_rabbit_pet setAlpha:1];
        
    }
    if ([icone  isEqual: @"bird"]) {
        [_btn_pet setAlpha:1];
        [_btn_bird_pet setAlpha:1];
        
    }
    
    self.txtname.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"name"]];
    self.txtemail.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"email"]];
    self.txtphone.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"phone"]];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)Close_pet:(id)sender {
    self.persone.hidden=YES;
    self.petview.hidden=YES;
    self.Primview.hidden=NO;
}

- (IBAction)Close_user:(id)sender {
    self.persone.hidden=YES;
    self.petview.hidden=YES;
    self.Primview.hidden=NO;
}
@end
