//
//  MenuViewController.m
//  DRugsReminder
//
//  Created by Youssef Bha on 24/04/2015.
//  Copyright (c) 2015 DrugsReminder. All rights reserved.
//

#import "MenuViewController.h"
#import "EditUserViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

- (IBAction)bt_adduser:(id)sender {
    EditUserViewController * p=[self.storyboard instantiateViewControllerWithIdentifier:@"Addusersb"];
    p.recordIDToEdit = -1;
    [self.navigationController pushViewController:p animated:YES];
}
@end
