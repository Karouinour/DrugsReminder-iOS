//
//  NewViewController.h
//  DRugsReminder
//
//  Created by Youssef Bha on 22/04/2015.
//  Copyright (c) 2015 DrugsReminder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import <sqlite3.h>

@interface NewViewController : UIViewController

@property(strong,nonatomic) NSString* databasePath;
@property (nonatomic) sqlite3* DB;
@property (strong, nonatomic) UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UICollectionView *listNews;
- (IBAction)home:(id)sender;

@end
