#import "ODViewController.h"
#import "CoreDataManager.h"

@interface ODViewController ()

@end

@implementation ODViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.detail;
    self.resultData = [[NSArray alloc] init];

    if (self.email && self.cid) {
        NSLog(@"cid: %@, email: %@", self.cid, self.email);
        
        NSManagedObjectContext *context = [[CoreDataManager sharedManager] managedObjectContext];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        request.predicate = [NSPredicate predicateWithFormat:@"email ==[c] %@ AND cid == %@", self.email , self.cid];


        NSError *error = nil;
        self.result = [[context executeFetchRequest:request error:&error] mutableCopy];
        NSLog(@"%@",_result);
        if (!error) {
            if (self.result.count > 0) {
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSManagedObject *employee in self.result) {
                    NSString *checkout = [employee valueForKey:@"outtime"];

                    NSString *name = [employee valueForKey:@"intime"];
                    
                    if (checkout && name) {
                        NSDictionary *userData = @{
                            @"name": [NSString stringWithFormat:@"Checkin: %@",[name capitalizedString]],
                            @"fullTitle": [NSString stringWithFormat:@"Checkout: %@", [checkout capitalizedString]]
                        };
                        
                        [tempArray addObject:userData];
                    }
                }
                self.resultData = [tempArray copy];
                [self.tableView reloadData];
            } else {
                NSLog(@"No user found with email: %@", self.email);
            }
        } else {
            NSLog(@"Error fetching User data: %@", error.localizedDescription);
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.resultData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *attendanceData = [self.resultData objectAtIndex:indexPath.section];
    cell.textLabel.text = attendanceData[@"name"];
    cell.detailTextLabel.text = attendanceData[@"fullTitle"];
    
    return cell;
}

@end
