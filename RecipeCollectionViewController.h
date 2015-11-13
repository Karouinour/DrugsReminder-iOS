//
//  RecipeCollectionViewController.h
//  CollectionViewDemo
//
//  Created by Simon on 9/1/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeCollectionViewController : UICollectionViewController

- (IBAction)shareButtonTouched:(id)sender;
@property (strong, nonatomic) NSMutableArray *list_title;






- (IBAction)home:(id)sender;

@end
