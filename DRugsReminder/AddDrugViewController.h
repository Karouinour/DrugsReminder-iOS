//
//  AddDrugViewController.h
//  DRugsReminder
//
//  Created by DrugsReminder on 17/04/2015.
//  Copyright (c) 2015 DrugsReminder. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EditInfoViewControllerDelegate

-(void)editingInfoWasFinished;

@end

@interface AddDrugViewController : UIViewController <UITextFieldDelegate>


@property (nonatomic, strong) id<EditInfoViewControllerDelegate> delegateDrug;

@property (weak, nonatomic) IBOutlet UITextField *txtname;

@property (nonatomic) int recordIDToEditDrug;

@property (nonatomic) NSString* idUser;



@property (nonatomic) NSString* icone;





//btn add drug

- (IBAction)btn_vial:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_vial;

- (IBAction)btn_Syrup:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_Syrup;

- (IBAction)btn_injection:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_injection;

- (IBAction)btn_pill:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_pill;

- (IBAction)btn_pomade:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_pomade;



- (IBAction)savedrug:(id)sender;



@end
