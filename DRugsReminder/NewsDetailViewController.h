//
//  NewsDetailViewController.h
//  DRugsReminder
//
//  Created by DrugsReminder on 24/04/2015.
//  Copyright (c) 2015 DrugsReminder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titrenew;
@property (weak, nonatomic) IBOutlet UIImageView *imagenew;
@property (weak, nonatomic) IBOutlet UILabel *descnew;


@property (weak, nonatomic) NSString *titre;
@property (weak, nonatomic) NSString *image;
@property (weak, nonatomic) NSString *desc;

@end
