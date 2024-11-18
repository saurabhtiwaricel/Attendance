//
//  OTableViewController.m
//  Attendance
//

#import "OTableViewController.h"
#import "OTableViewCell.h"
#import "ViewController.h"
#import "CoreDataManager.h"
#import "ODViewController.h"

@interface OTableViewController ()

@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation OTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArray = [[NSMutableArray alloc] init];
    
    if (self.cid && self.email) {
        NSLog(@"cid: %@, email: %@", self.cid, self.email);

        NSManagedObjectContext *context = [[CoreDataManager sharedManager] managedObjectContext];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        request.predicate = [NSPredicate predicateWithFormat:@"cid == %@", self.cid];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        
        if (!error) {
            if (result.count > 0) {
                for (NSManagedObject *employee in result) {
//                    NSString *name = [employee valueForKey:@"password"];
                    NSString *email = [employee valueForKey:@"email"];
                    
                    NSString *fullTitle = [NSString stringWithFormat:@"%@", [email capitalizedString]];
                    [self.titleArray addObject:fullTitle];
                }
            } else {
                NSLog(@"No user found with email: %@", self.email);
            }
        } else {
            NSLog(@"Error fetching User data: %@", error.localizedDescription);
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.cellLabel.text = self.titleArray[indexPath.row];
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showAttendance"]) {
        ODViewController *detailView = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        if (indexPath) {
            detailView.detail = self.titleArray[indexPath.row];
            detailView.email = [self.titleArray objectAtIndex:indexPath.row];
            detailView.cid = self.cid;
        }
    }
}

@end
