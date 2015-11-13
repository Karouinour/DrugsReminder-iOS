//
//  News2detailViewController.m
//  DRugsReminder
//
//  Created by DrugsReminder on 08/05/2015.
//  Copyright (c) 2015 DrugsReminder. All rights reserved.
//

#import "News2detailViewController.h"

@interface News2detailViewController ()

@end

@implementation News2detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.detailimage2.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_image2]]];
    self.detailtitre2.text = _titre2;
    self.detaildescription2.text = _description2;
    
    
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

@end
