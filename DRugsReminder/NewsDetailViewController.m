//
//  NewsDetailViewController.m
//  DRugsReminder
//
//  Created by DrugsReminder on 24/04/2015.
//  Copyright (c) 2015 DrugsReminder. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imagenew.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_image]]];
    self.titrenew.text = _titre;
    self.descnew.text = _desc;
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
