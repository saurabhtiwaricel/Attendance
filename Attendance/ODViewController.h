//
//  ODTableViewController.h
//  Attendance
//
//  Created by Celestial on 11/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ODViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) NSString *cid;
@property(strong,nonatomic) NSString *email;
@property(strong,nonatomic) NSString *time;

@property (nonatomic, strong) NSString *capname;
@property (nonatomic, strong) NSString *fullTitle;
@property (nonatomic, strong) NSArray *result;
@property(strong, nonatomic) NSString *detail;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *resultData;
@end

NS_ASSUME_NONNULL_END
