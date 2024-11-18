//
//  ViewController.m
//  Attendance
//
//  Created by Celestial on 07/11/24.
//

#import "ViewController.h"
#import "CoreDataManager.h"
#import <CoreData/CoreData.h>
#import "ProfileViewController.h"
#import "OTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)loginAction:(id)sender __attribute__((ibaction)) {
    
    NSString *email = self.emailText.text;
    NSString *password = self.password.text;
    NSString *cid = self.idTextFild.text;
    NSString *entityName = (self.segoutlet.selectedSegmentIndex == 1) ? @"User" : @"Organisation";
    NSString *viewControllerID = (self.segoutlet.selectedSegmentIndex == 1) ? @"UserView" : @"ocell";
    
    if (email.length == 0 || password.length == 0) {
        NSLog(@"email and password are required.");
        return;
    }
    
    NSManagedObjectContext *context = [[CoreDataManager sharedManager] managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"email == %@ AND password == %@ AND cid == %@", email, password, cid];
    
    NSError *error;
    NSArray *matchingUsers = [context executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Error fetching user: %@", error.localizedDescription);
        return;
    }
    
    if (matchingUsers.count > 0) {
        NSLog(@"Login successful!");
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        if ([viewControllerID isEqualToString:@"UserView"]) {
            ProfileViewController *pvc = [storyboard instantiateViewControllerWithIdentifier:viewControllerID];
            pvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            pvc.cid = cid;
            pvc.email = email;
            [self.navigationController pushViewController:pvc animated:YES];
        } else {
            OTableViewController *otvc = [storyboard instantiateViewControllerWithIdentifier:viewControllerID];
            otvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            otvc.cid = cid;
            otvc.email = email;
            [self.navigationController pushViewController:otvc animated:YES];
        }
    } else {
        NSLog(@"Invalid credentials.");
    }
}

- (IBAction)segaction:(id)sender {
    
}

@end
