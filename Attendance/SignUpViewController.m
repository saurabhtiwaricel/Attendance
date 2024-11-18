#import "SignUpViewController.h"
#import "CoreDataManager.h"
#import <CoreData/CoreData.h>

@implementation SignUpViewController

- (IBAction)options:(id)sender {
    if (self.segout.selectedSegmentIndex == 1) {
        self.segout.backgroundColor = [UIColor greenColor];
    }
    else{
        self.segout.backgroundColor = [UIColor redColor];
    }
}

- (IBAction)signUpAction:(id)sender {
    
        NSString *username = self.usernameTextField.text;
        NSString *password = self.passwordTextField.text;
        NSString *cid = self.RId.text;
        NSString *cnumber = self.Cn.text;
        NSString *email = self.emailid.text;
        
        if (username.length == 0 || password.length == 0 || email.length == 0) {
            NSLog(@"Username, password, and email are required.");
            return;
        }
        
        NSManagedObjectContext *context = [[CoreDataManager sharedManager] managedObjectContext];
        
  
    
    NSString *entityName = (self.segout.selectedSegmentIndex == 1) ? @"User" : @"Organisation";
    
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"email == %@", email];
        
        NSError *error;
        NSArray *existingUsers = [context executeFetchRequest:fetchRequest error:&error];
        
        if (existingUsers.count > 0) {
            NSLog(@"User already exists");
            return;
        }
        
      

        
        NSManagedObject *user = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
        [user setValue:username forKey:@"username"];
        [user setValue:password forKey:@"password"];
        [user setValue:cid forKey:@"cid"];
        [user setValue:cnumber forKey:@"cnumber"];
        [user setValue:email forKey:@"email"];
        
        [[CoreDataManager sharedManager] saveContext];
        
        NSLog(@"User registered successfully!");
 
        [self.navigationController popViewControllerAnimated:YES];
    }



@end
