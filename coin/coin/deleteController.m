//
//  deleteController.m
//  coin
//
//  Created by Richard Dawson on 11/29/16.
//  Copyright © 2016 Richard Dawson. All rights reserved.
//

#import "deleteController.h"
#import <Parse/Parse.h>
#import <SCLAlertView.h>

@interface deleteController ()
@property (strong, nonatomic) IBOutlet UIButton *deleteAccountRed;

@end

@implementation deleteController

//Delete Account button pressed
- (IBAction)deleteAccount:(id)sender {
//    SCLAlertView *alert = [[SCLAlertView alloc] init];
//    
//    [alert addButton:@"Yes" actionBlock:^(void) {
//        
//        //Get the current User LoggedIn
//        PFUser *user = [PFUser currentUser];
//        
//        //Start the loading spinner
//        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        spinner.center = _deleteAccountRed.center;
//        spinner.transform = CGAffineTransformMakeScale(1.8, 1.8);
//        spinner.tag = 12;
//        [_deleteAccountRed.superview insertSubview:spinner aboveSubview:_deleteAccountRed];
//        [spinner startAnimating];
//        [_deleteAccountRed setTitle:@"" forState:UIControlStateNormal];
//        
//        //Pull all expenses for that user
//        PFQuery *query2 = [PFQuery queryWithClassName:@"expense"];
//        [query2 whereKey:@"user" equalTo:user.username];
//        [query2 findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError *error) {
//            
//            //If no errors
//            if (!error) {
//                
//                //Loop through user's expenses
//                for (PFObject *object in objects) {
//                    
//                    //Delete expense
//                    [object deleteInBackground];
//                    
//                }
//                
//                //Delete the user
//                [[PFUser currentUser] deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                    
//                    //Set title back to normal
//                    [_deleteAccountRed setTitle:@"Delete Account" forState:UIControlStateNormal];
//                    
//                    //If no errors
//                    if (!error) {
//                        
//                        //Go to create account screen
//                        [self performSegueWithIdentifier:@"deleteAccount" sender:nil];
//                    }
//                    
//                    //If error, then alert user
//                    else{
//                        NSLog(@"Error: %@ %@", error, [error userInfo]);
//                    }
//                }];
//                
//            }
//            
//            else {
//                
//                //Set title back to normal
//                [_deleteAccountRed setTitle:@"Delete Account" forState:UIControlStateNormal];
//                
//                // Log details of the failure
//                NSLog(@"Error: %@ %@", error, [error userInfo]);
//            }
//        }];
//        
//    }];
//    
//    
//    [alert showWarning:self title:@"Alert" subTitle:@"Are you sure you would like to delete your account? This cannot be undone." closeButtonTitle:@"No" duration:0.0f];
    
        //Make sure user wants to delete their account and data
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Alert"
                                     message:@"Are you sure you would like to delete your account? This cannot be undone."
                                     preferredStyle:UIAlertControllerStyleAlert];
    
        //If the user says yes
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
    
                                        //Get the current User LoggedIn
                                        PFUser *user = [PFUser currentUser];
    
                                        //Pull all expenses for that user
                                        PFQuery *query2 = [PFQuery queryWithClassName:@"expense"];
                                        [query2 whereKey:@"user" equalTo:user.username];
                                        [query2 findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError *error) {
    
                                            //If no errors
                                            if (!error) {
    
                                                //Loop through user's expenses
                                                for (PFObject *object in objects) {
    
                                                    //Delete expense
                                                    [object deleteInBackground];
    
                                                }
    
                                                //Delete the user
                                                [[PFUser currentUser] deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    
                                                    //If no errors
                                                    if (!error) {
                                                        //Gets rid of session t
                                                        [PFUser logOut];
                                                        //Go to create account screen
                                                        [self performSegueWithIdentifier:@"deleteAccount" sender:nil];
                                                    }
    
                                                    //If error, then alert user
                                                    else{
                                                        NSLog(@"Error: %@ %@", error, [error userInfo]);
                                                    }
                                                }];
    
                                            }
    
                                            else {
                                                // Log details of the failure
                                                NSLog(@"Error: %@ %@", error, [error userInfo]);
                                            }
                                        }];
    
                                    }];
    
        //If User chooses no
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"No"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       
                                   }];
        
        [alert addAction:yesButton];
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set the title of the page
    self.title = @"Delete Account";
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
