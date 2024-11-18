//
//  SignUpViewController.h
//  Attendance
//
//  Created by Celestial on 07/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *RId;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailid;
@property (weak, nonatomic) IBOutlet UITextField *Cn;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;

- (IBAction)signUpAction:(id)sender;

- (IBAction)options:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segout;


@end

NS_ASSUME_NONNULL_END
