#import <UIKit/UIKit.h>

@protocol EditInfoViewControllerDelegate

-(void)editingInfoWasFinished;

@end


@interface EditUserViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) id<EditInfoViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *txtname;

@property (weak, nonatomic) IBOutlet UITextField *txtemail;

@property (weak, nonatomic) IBOutlet UITextField *txtphone;

@property (weak, nonatomic) NSString *txticone;

//primview

@property (weak, nonatomic) IBOutlet UIView *Primview;

//view Homme et femme
@property (weak, nonatomic) IBOutlet UIView *persone;


//view Pet
@property (weak, nonatomic) IBOutlet UIView *petview;


//id user(param)
@property (nonatomic) int recordIDToEdit;

//btn selection
- (IBAction)btn_homme:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_homme;

- (IBAction)btn_femme:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_femme;
- (IBAction)btn_pet:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_pet;



//btn view pet
- (IBAction)btn_cat_pet:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_cat_pet;

- (IBAction)btn_horse_pet:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_horse_pet;

- (IBAction)btn_dog_pet:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_dog_pet;

- (IBAction)btn_rabbit_pet:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_rabbit_pet;

- (IBAction)btn_bird_pet:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_bird_pet;





- (IBAction)Close_pet:(id)sender;
- (IBAction)Close_user:(id)sender;




//@property (weak, nonatomic) IBOutlet UIButton *back;

//- (IBAction)back:(id)sender;

- (IBAction)saveInfo:(id)sender;

@end
