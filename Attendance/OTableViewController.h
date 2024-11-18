//
//  OTableViewController.h
//  Attendance
//
//  Created by Celestial on 10/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTableViewController : UITableViewController{
    NSArray *title;
}
@property(strong,nonatomic) NSString *cid;
@property(strong,nonatomic) NSString *email;



@end

NS_ASSUME_NONNULL_END
