#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "EditUserViewController.h"

@interface ListUsersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, EditInfoViewControllerDelegate>

- (IBAction)pushViewController:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tblPeople;


- (IBAction)addNewRecord:(id)sender;

- (IBAction)home:(id)sender;

@end
