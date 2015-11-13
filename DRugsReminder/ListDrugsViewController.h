//
//  ListDrugs.h
//  DRugsReminder
//
//  Created by KarouiNoour on 3/5/15.
//  Copyright (c) 2015 DrugsReminder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "AddDrugViewController.h"

@interface ListDrugsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, EditInfoViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tabledrugs;
@property (nonatomic) NSString * ID2;

- (IBAction)addnewdrug:(id)sender;

@end
