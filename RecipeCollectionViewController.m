//
//  RecipeCollectionViewController.m
//  CollectionViewDemo
//
//  Created by Simon on 9/1/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "RecipeCollectionViewController.h"
#import "RecipeViewCell.h"
#import "RecipeCollectionHeaderView.h"
#import "RecipeViewController.h"

#import <Social/Social.h>

@interface RecipeCollectionViewController () {
    NSArray *recipeImages;
    NSArray *titreprecaution;
    NSArray *descprecaution;
    BOOL shareEnabled;
    NSMutableArray *selectedRecipes;
}

@end

@implementation RecipeCollectionViewController

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
     self.navigationItem.title = @"Precaution";
    
    // Initialize recipe image array
    NSArray *mainDishImages = [NSArray arrayWithObjects:@"1.png", @"2.png", @"3.png", @"4.png", @"5.png", @"6.png",@"7.png", nil];
    NSArray *arrtitle = [NSArray arrayWithObjects:
                         @"Follow the instructions",
                         @"Beware of cons-indications",
                         @"Be very attentive to situations that change conditions of employment",
                         @"Adjust your lifestyle",
                         @"Respect the the medication treatment modalities",
                         @"Adopt the right attitude if you notice any side effects",
                         @"Use extra caution if you are taking a medication without a prescription", nil];
    NSArray *arrdesc = [NSArray arrayWithObjects:
                        @"A drug is intended to cure, relieve or prevent many specific diseases. Apartfrom this case,the medication can be dangerous and increases the risk of developing side effects Never give a medication that was prescribed to someone else, even if you do have the symptoms.",
                        
                        
                        @"It is the case you should never take certain medications, for example if you are allergic to or if you are pregnant.",
                        
                        
                        @"Coexistence of another disease, malfunction of an organ, age Taking one or more other drugs. Presence of certain excipients (different substances of the active substances of the medicament, for example lactose or sucrose, and presenting risks during certain diseases or in allergic subjects).",
                        
                        
                        @"Attention to certain foods or drinks that can influence the activity of your medication. Your ability to drive or operate machinery, to breastfeed or to practice competitive sports can be changed by the drug. Some treatments may require precautions, such as following a contraceptive method.",
                        
                        
                        @"Dosage: the precise amount of drug that must be taken and at what pace. Do not under any circumstances modify the medication without telling your doctor or pharmacist. Treatment duration: In some cases, you should never interrupt it.Some drugs require administration conditions specific: specific times, taken with or between meals ... The administration device of your medicine (measuring spoon, dropper, syringe graduated ...) must not be used with other drugs. The notice also tells you what to do if you have taken more medicine that you should or, conversely, if you forget to take your medicine.",
                        
                        
                        @"If you see an adverse reaction (the drug has been used at normal doses or in non-recommended conditions), contact your doctor or pharmacist; it will give you what to do.",
                        
                        
                        @"The drug has been prescribed to you or that you bought it from a pharmacy by your self, you must read all the rubric of the notice. In case of inefficiency, of appearance of an adverse effect or simply doubt, ask the advice of your doctor or pharmacist.", nil];
    
    
    
    
    
    
    recipeImages = [NSArray arrayWithObjects:mainDishImages,  nil];
    titreprecaution =[NSArray arrayWithObjects:arrtitle,  nil];
    descprecaution =[NSArray arrayWithObjects:arrdesc,  nil];
    
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 25, 20, 25);
    
    selectedRecipes = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [recipeImages count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[recipeImages objectAtIndex:section] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        RecipeCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        NSString *title = [[NSString alloc]initWithFormat:@"Recipe Group #%i", indexPath.section + 1];
        headerView.title.text = title;
        UIImage *headerImage = [UIImage imageNamed:@"header_banner.png"];
        headerView.backgroundImage.image = headerImage;
        
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    RecipeViewCell *cell = (RecipeViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:[recipeImages[indexPath.section] objectAtIndex:indexPath.row]];
    
    
    
    cell.layer.cornerRadius = 5.75f;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRecipePhoto"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        RecipeViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        
        destViewController.recipeImageName = [recipeImages[indexPath.section] objectAtIndex:indexPath.row];
        
        destViewController.title =[titreprecaution [indexPath.section] objectAtIndex:indexPath.row];
        NSLog(@"%@",[descprecaution [indexPath.section] objectAtIndex:indexPath.row]);
        destViewController.description2 =[descprecaution [indexPath.section] objectAtIndex:indexPath.row];
        
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (shareEnabled) {
        NSString *selectedRecipe = [recipeImages[indexPath.section] objectAtIndex:indexPath.row];
        [selectedRecipes addObject:selectedRecipe];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (shareEnabled) {
        NSString *deSelectedRecipe = [recipeImages[indexPath.section] objectAtIndex:indexPath.row];
        [selectedRecipes removeObject:deSelectedRecipe];
    }
}

-(void)home:(id)sender{
     [self.navigationController popToRootViewControllerAnimated:(YES)];
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if (shareEnabled) {
        return NO;
    } else {
        return YES;
    }
}


@end
