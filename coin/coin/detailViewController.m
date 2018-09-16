//
//  detailViewController.m
//  coin
//
//  Created by Richard Dawson on 12/1/16.
//  Copyright © 2016 Richard Dawson. All rights reserved.
//

#import "detailViewController.h"
#import <Parse/Parse.h>

@interface detailViewController ()

@end

@implementation detailViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.positionInArray) {
        [self loadData];
    }
}

-(void)loadData {
    //Get the current User LoggedIn
    PFUser *user = [PFUser currentUser];
    
    //Pull all expenses for that user
    PFQuery *query2 = [PFQuery queryWithClassName:@"expense"];
    [query2 whereKey:@"user" equalTo:user.username];
    //[query2 whereKey:@"expenseType" equalTo:_segment];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError *error) {
        
        if (!error) {
            
            //Grab all the expense objects
            expenses = [NSMutableArray arrayWithObjects: @"", nil];
            [expenses removeLastObject];
            for (PFObject *object in objects) {
                [expenses addObject:object];
                NSLog(@"%@", object);
                
            }
            
            
            NSDictionary* d = expenses[_positionInArray.row];
            
            key = [expenses[_positionInArray.row] objectId];
            
            self.expenseName.text = d[@"expenseName"];
            self.expenseType.text = d[@"expenseType"];
            self.expenseNotes.text = d[@"expenseNotes"];
            self.expensePrice.text = d[@"expensePrice"];
            
            if([d[@"completedBool"]  isEqual: @"NO"])
            {
                [self.expenseSwitch setOn:NO];
            }
            else if([d[@"completedBool"]  isEqual: @"YES"])
            {
                [self.expenseSwitch setOn:YES];
            }
   
        }
        
        else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Mark Expense";
    
    //Create the + button
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveBtnTouched:)];
    self.navigationItem.rightBarButtonItem = item;
    
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)deleteExpense:(id)sender {
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Alert"
                                 message:@"Are you sure you would like to delete this expense? This cannot be undone."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    PFQuery *query = [PFQuery queryWithClassName:@"expense"];
                                    
                                    // Retrieve the object by id
                                    [query getObjectInBackgroundWithId:key
                                                                 block:^(PFObject *expense, NSError *error) {
                                                                     
                                                                     [expense deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                                                         if (succeeded) {
                                                                             // The object has been saved.
                                                                             //Perform Segue
                                                                             [self.navigationController popViewControllerAnimated:YES];
                                                                         } else {
                                                                             // There was a problem, check error.description
                                                                         }
                                                                     }];
                                                                     
                                                                 }];
                                    
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];

}


-(void)saveBtnTouched:(id)sender {
    
    //Used to see if there are any errors
    bool errors = false;
    
    //Check to make sure all fields are filled out
    if(([_expenseName.text  isEqual: @""]) || ([_expensePrice.text  isEqual: @""]))
    {
        errors = true;
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Form Error"
                                     message:@"All required fields must be filled out"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                   }];
        
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    //Scanner to check if a valid double was inputted
    NSScanner *scanner = [NSScanner scannerWithString:_expensePrice.text];
    BOOL isNumeric = [scanner scanDouble:NULL] && [scanner isAtEnd];
    
    //If not a number, then alert the user
    if(isNumeric == NO)
    {
        errors = true;
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Form Error"
                                     message:@"Must be a number"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                   }];
        
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    //If no errors were found
    if(errors == false)
    {
        PFQuery *query = [PFQuery queryWithClassName:@"expense"];
        
        // Retrieve the object by id
        [query getObjectInBackgroundWithId:key
                                     block:^(PFObject *expense, NSError *error) {
                                         // Now let's update it with some new data. In this case, only cheatMode and score
                                         // will get sent to the cloud. playerName hasn't changed.
                                         if([self.expenseSwitch isOn])
                                         {
                                             expense[@"completedBool"] = @"YES";
                                         }
                                         else{
                                             expense[@"completedBool"] = @"NO";
                                         }
                                         
                                         expense[@"expenseName"] = self.expenseName.text;
                                         expense[@"expenseNotes"] = self.expenseNotes.text;
                                         expense[@"expensePrice"] = self.expensePrice.text;
                                         [expense saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                             if (succeeded) {
                                                 // The object has been saved.
                                                 //Perform Segue
                                                 [self.navigationController popViewControllerAnimated:YES];
                                             } else {
                                                 // There was a problem, check error.description
                                             }
                                         }];   

                                     }];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
