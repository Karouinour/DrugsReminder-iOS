//
//  RecipeViewController.m
//  CollectionViewDemo
//
//  Created by Simon on 16/2/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "RecipeViewController.h"

@interface RecipeViewController ()

@end

@implementation RecipeViewController

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
	self.recipeImageView.image = [UIImage imageNamed:self.recipeImageName];
    self.precautiontitre.text = self.title;
    self.precautiondesc.text = self.description2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
