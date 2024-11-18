//
//  ProfileViewController.h
//  Attendance
//
//  Created by Celestial on 07/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *namelbl;

@property (weak, nonatomic) IBOutlet UILabel *userEmailLbl;
@property (weak, nonatomic) IBOutlet UILabel *userMbileLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIDlbl;
@property (weak, nonatomic) IBOutlet UIButton *chackinOutlet;
@property (weak, nonatomic) IBOutlet UIButton *chackOutlet;
- (IBAction)ChackinAction:(id)sender;
- (IBAction)chackOutAction:(id)sender;
- (IBAction)logoutAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *intime;
@property (weak, nonatomic) IBOutlet UILabel *outtimelbl;



@property(strong,nonatomic) NSString *cid;
@property(strong,nonatomic) NSString *email;



@end

NS_ASSUME_NONNULL_END
