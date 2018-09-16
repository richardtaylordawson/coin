//
//  LoginPageController.m
//  
//
//  Created by Richard Dawson on 11/27/16.
//
//

#import "LoginPageController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import <RFKeyboardToolbar.h>

@interface LoginPageController ()

//Outlets for username and password
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *logInButton;

@end

@implementation LoginPageController

//Next button clicked on username
- (IBAction)usernameNext:(id)sender {
    
    //Goes to Password
    [_password becomeFirstResponder];
}

//Done button clicked on password
- (IBAction)passwordDoneBtn:(id)sender {
    
    //Keyboard goes away
    [_password resignFirstResponder];
}

//Login button pushed
- (IBAction)logInButton:(id)sender {
    
    //Start the loading spinner
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.center = _logInButton.center;
    spinner.transform = CGAffineTransformMakeScale(1.8, 1.8);
    spinner.tag = 12;
    [_logInButton.superview insertSubview:spinner aboveSubview:_logInButton];
    [spinner startAnimating];
    [_logInButton setTitle:@"" forState:UIControlStateNormal];
    
    //Check to make sure all the fields are filled out
    if(([_username.text  isEqual: @""]) || ([_password.text  isEqual: @""]))
    {
        //Stop the loading spinner
        [[self.view viewWithTag:12] stopAnimating];
        [_logInButton setTitle:@"Log In" forState:UIControlStateNormal];
        
        //Pop up the alert
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Log In Problem"
                                     message:@"All fields must be filled out"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                   }];
        
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];

    }
    
    //If no errors, then start the log in
    [PFUser logInWithUsernameInBackground:_username.text password:_password.text
                            block:^(PFUser *user, NSError *error) {
                                
                                        //Log in successful
                                        if (user)
                                        {
                                            //Stop the loading spinner
                                            [[self.view viewWithTag:12] stopAnimating];
                                            [_logInButton setTitle:@"Log In" forState:UIControlStateNormal];
                                            
                                            //Go to main tab view controller
                                            [self performSegueWithIdentifier:@"tabView" sender:nil];
                                            
                                        }
                                
                                        //Log in unsuccessful
                                        else
                                        {
                                            //Stop the loading spinner
                                            [[self.view viewWithTag:12] stopAnimating];
                                            [_logInButton setTitle:@"Log In" forState:UIControlStateNormal];
                                            
                                            //Get the error
                                            NSString *errorString = [error userInfo][@"error"];
                                            
                                            //Invalid username and password
                                            if([errorString isEqual: @"Invalid username/password."])
                                                
                                            {
                                                // The login failed. Check error to see why.
                                                UIAlertController * alert = [UIAlertController
                                                                             alertControllerWithTitle:@"Log In Error"
                                                                             message:@"Invalid Username/Password"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
                                                
                                                UIAlertAction* okButton = [UIAlertAction
                                                                           actionWithTitle:@"OK"
                                                                           style:UIAlertActionStyleDefault
                                                                           handler:^(UIAlertAction * action) {
                                                                           }];
                                                
                                                [alert addAction:okButton];
                                                
                                                [self presentViewController:alert animated:YES completion:nil];
                                                
                                            }
                                            
                                            //Unknown error occured
                                            UIAlertController * alert = [UIAlertController
                                                                         alertControllerWithTitle:@"Error"
                                                                         message:@"Unknown"
                                                                         preferredStyle:UIAlertControllerStyleAlert];
                                            
                                            UIAlertAction* okButton = [UIAlertAction
                                                                       actionWithTitle:@"OK"
                                                                       style:UIAlertActionStyleDefault
                                                                       handler:^(UIAlertAction * action) {
                                                                       }];
                                            
                                            [alert addAction:okButton];
                                            
                                            [self presentViewController:alert animated:YES completion:nil];

                                        }
                                    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //Username Done Button
//    RFToolbarButton *usernameDone = [RFToolbarButton buttonWithTitle:@"Done"];
//    [usernameDone addEventHandler:^{
//        [_username resignFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    usernameDone.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [usernameDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Username Next Button
//    RFToolbarButton *usernameNext = [RFToolbarButton buttonWithTitle:@"Next"];
//    [usernameNext addEventHandler:^{
//        [_password becomeFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    usernameNext.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [usernameNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Add Username Buttons
//    _username.inputAccessoryView = [RFKeyboardToolbar toolbarWithButtons:@[usernameDone, usernameNext]];
//    [self.view addSubview:_username];
//    
//    //Password Confirm Done Button
//    RFToolbarButton *password2Done = [RFToolbarButton buttonWithTitle:@"Done"];
//    [password2Done addEventHandler:^{
//        [_password resignFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    password2Done.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [password2Done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Password Previous Button
//    RFToolbarButton *passwordConfirmPrevious = [RFToolbarButton buttonWithTitle:@"Previous"];
//    [passwordConfirmPrevious addEventHandler:^{
//        [_username becomeFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    passwordConfirmPrevious.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [passwordConfirmPrevious setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Add Password Confirm Buttons
//    _password.inputAccessoryView = [RFKeyboardToolbar toolbarWithButtons:@[password2Done, passwordConfirmPrevious]];
//    [self.view addSubview:_password];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
