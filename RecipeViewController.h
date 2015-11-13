//
//  RecipeViewController.h
//  CollectionViewDemo
//
//  Created by Simon on 16/2/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) NSString *recipeImageName;
@property (weak, nonatomic) IBOutlet UILabel *precautiontitre;
@property (weak, nonatomic) IBOutlet UILabel *precautiondesc;

//@property (weak, nonatomic) NSString *ImageName;
//@property (weak, nonatomic) NSString *ImageDetail;
@property (weak, nonatomic) NSString *title;

@property (weak, nonatomic) NSString *description2;


- (IBAction)close:(id)sender;


@end
