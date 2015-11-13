#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "CellNews.h"
#import "NewsDetailViewController.h"
#import <sqlite3.h>

@interface NewsViewController : UIViewController

@property(strong,nonatomic) NSString* databasePath;
@property (nonatomic) sqlite3* DB;

@property (strong, nonatomic) IBOutlet UITableView *TableNews;

- (IBAction)home:(id)sender;


@end
