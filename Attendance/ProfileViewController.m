//
//  ProfileViewController.m
//  Attendance
//
//  Created by Celestial on 07/11/24.


#import "ProfileViewController.h"
#import "CoreData/CoreData.h"
#import "CoreDataManager.h"
#import "ViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;

    
    
    if (self.cid && self.email) {
        NSLog(@"cid: %@,email: %@", self.cid, self.email);

       
        NSManagedObjectContext *context = [[CoreDataManager sharedManager] managedObjectContext];
        

        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        
    
        request.predicate = [NSPredicate predicateWithFormat:@"email == %@", self.email];
        
            
        
        
      
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        
        if (!error) {
            if (result.count > 0) {
                for (NSManagedObject *employee in result) {
                    NSString *name = [employee valueForKey:@"username"];
                    NSString *email = [employee valueForKey:@"email"];
                    NSString *number = [employee valueForKey:@"cnumber"];
                    NSString *oid = [employee valueForKey:@"cid"];
                    
                    
                    
                    
                    NSString *capName = [name capitalizedString];
                    self.namelbl.text = [NSString stringWithFormat:@"Name: %@",capName];
                    
                    NSString *capEmail = [email capitalizedString];
                    self.userEmailLbl.text = [NSString stringWithFormat:@"Email: %@",capEmail];
                    
                    NSString *capNumber = [number capitalizedString];
                    self.userMbileLbl.text = [NSString stringWithFormat:@"Number %@",capNumber];
                    
                    NSString *capid = [oid capitalizedString];
                    self.userIDlbl.text = [NSString stringWithFormat:@"Id %@",capid];
                }
            } else {
                NSLog(@"No user found with email: %@", self.email);
            }
        } else {
            NSLog(@"Error fetching User data: %@", error.localizedDescription);
        }
        NSLog(@"Result: %@", result);
    }

}

- (IBAction)logoutAction:(id)sender {

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)chackOutAction:(id)sender {
    
    self.chackOutlet.enabled = NO;

    
    [NSTimer scheduledTimerWithTimeInterval:7
                                     target:self
                                   selector:@selector(enableButtonOut)
                                   userInfo:nil
                                    repeats:NO];

    [self saveCurrentTimeForType:@"outtime"];
}

- (IBAction)ChackinAction:(id)sender {

    self.chackinOutlet.enabled = NO;

    [NSTimer scheduledTimerWithTimeInterval:7 
                                     target:self
                                   selector:@selector(enableButtonIN)
                                   userInfo:nil
                                    repeats:NO];
    [self saveCurrentTimeForType:@"intime"];
    
}



- (void)saveCurrentTimeForType:(NSString *)timeType {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    NSString *currentTimeString = [formatter stringFromDate:currentDate];
    
    if ([timeType isEqualToString:@"intime"]) {
        self.intime.text = currentTimeString;
    } else if ([timeType isEqualToString:@"outtime"]) {
        self.outtimelbl.text = currentTimeString;
    }
    
    NSManagedObjectContext *context = [[CoreDataManager sharedManager] managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"email == %@", self.email];
    
    NSError *error;
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    if (!error && result.count > 0) {
        NSManagedObject *employee = result.firstObject;
        
        if ([timeType isEqualToString:@"intime"]) {
            [employee setValue:currentTimeString forKey:@"intime"];
        } else if ([timeType isEqualToString:@"outtime"]) {
            [employee setValue:currentTimeString forKey:@"outtime"];
        }
        
        if ([context save:&error]) {
            NSLog(@"%@ saved successfully.", timeType);
        } else {
            NSLog(@"Failed to save %@: %@", timeType, error.localizedDescription);
        }
    } else {
        NSLog(@"Error fetching User data for saving %@: %@", timeType, error.localizedDescription);
    }
}


- (void)enableButtonIN {
    self.chackinOutlet.enabled = YES;
}
- (void)enableButtonOut {
    self.chackOutlet.enabled = YES;
}

@end
