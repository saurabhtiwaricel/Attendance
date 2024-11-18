//
//  ViewController.h
//  Attendance
//
//  Created by Celestial on 07/11/24.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailText;

@property (weak, nonatomic) IBOutlet UITextField *idTextFild;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)loginAction:(id)sender;


@property (weak, nonatomic) IBOutlet UISegmentedControl *segoutlet;

- (IBAction)segaction:(id)sender;



@end

