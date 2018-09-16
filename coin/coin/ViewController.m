//
//  ViewController.m
//  coin
//
//  Created by Richard Dawson on 11/7/16.
//  Copyright © 2016 Richard Dawson. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import <RFKeyboardToolbar.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *createAccount;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
//        [_email becomeFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    usernameNext.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [usernameNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Add Username Buttons
//    _username.inputAccessoryView = [RFKeyboardToolbar toolbarWithButtons:@[usernameDone, usernameNext]];
//    [self.view addSubview:_username];
//    
//    //Email Done Button
//    RFToolbarButton *emailDone = [RFToolbarButton buttonWithTitle:@"Done"];
//    [emailDone addEventHandler:^{
//        [_email resignFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    emailDone.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [emailDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Email Previous Button
//    RFToolbarButton *emailPrevious = [RFToolbarButton buttonWithTitle:@"Previous"];
//    [emailPrevious addEventHandler:^{
//        [_username becomeFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    emailPrevious.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [emailPrevious setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Email Next Button
//    RFToolbarButton *emailNext = [RFToolbarButton buttonWithTitle:@"Next"];
//    [emailNext addEventHandler:^{
//        [_password becomeFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    emailNext.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [emailNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //@ button
//    RFToolbarButton *atButton = [RFToolbarButton buttonWithTitle:@"@"];
//    [atButton addEventHandler:^{
//        _email.text = [_email.text stringByAppendingString:@"@"];
//    } forControlEvents:UIControlEventTouchUpInside];
//    atButton.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [atButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //@yahoo.com button
//    RFToolbarButton *dotComButton = [RFToolbarButton buttonWithTitle:@".com"];
//    [dotComButton addEventHandler:^{
//        _email.text = [_email.text stringByAppendingString:@".com"];
//    } forControlEvents:UIControlEventTouchUpInside];
//    dotComButton.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [dotComButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Add Email Buttons
//    _email.inputAccessoryView = [RFKeyboardToolbar toolbarWithButtons:@[emailDone, emailPrevious, emailNext, atButton, dotComButton]];
//    [self.view addSubview:_email];
//    
//    //Password Done Button
//    RFToolbarButton *passwordDone = [RFToolbarButton buttonWithTitle:@"Done"];
//    [passwordDone addEventHandler:^{
//        [_password resignFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    passwordDone.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [passwordDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Password Previous Button
//    RFToolbarButton *passwordPrevious = [RFToolbarButton buttonWithTitle:@"Previous"];
//    [passwordPrevious addEventHandler:^{
//        [_email becomeFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    passwordPrevious.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [passwordPrevious setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Password Next Button
//    RFToolbarButton *passwordNext = [RFToolbarButton buttonWithTitle:@"Next"];
//    [passwordNext addEventHandler:^{
//        [_passwordconfirm becomeFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    passwordNext.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [passwordNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Add Password Buttons
//    _password.inputAccessoryView = [RFKeyboardToolbar toolbarWithButtons:@[passwordDone, passwordPrevious, passwordNext]];
//    [self.view addSubview:_password];
//    
//    //Password Confirm Done Button
//    RFToolbarButton *password2Done = [RFToolbarButton buttonWithTitle:@"Done"];
//    [password2Done addEventHandler:^{
//        [_passwordconfirm resignFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    password2Done.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [password2Done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Password Previous Button
//    RFToolbarButton *passwordConfirmPrevious = [RFToolbarButton buttonWithTitle:@"Previous"];
//    [passwordConfirmPrevious addEventHandler:^{
//        [_password becomeFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    passwordConfirmPrevious.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [passwordConfirmPrevious setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Add Password Confirm Buttons
//    _passwordconfirm.inputAccessoryView = [RFKeyboardToolbar toolbarWithButtons:@[password2Done, passwordConfirmPrevious]];
//    [self.view addSubview:_passwordconfirm];
    
    
}


//Next Key Pressed on Username
- (IBAction)usernameNext:(id)sender {
    //Goes to Email
    [_email becomeFirstResponder];
}

//Next Key Pressed on Email
- (IBAction)emailNext:(id)sender {
    //Goes to Email
    [_password becomeFirstResponder];
}

//Next Key Pressed on Password
- (IBAction)passwordNext:(id)sender {
    //Goes to Email
    [_passwordconfirm becomeFirstResponder];
}

//Done Key Pressed on Confirm Password Box
- (IBAction)confirmPasswordDone:(id)sender {
    //Keyboard Goes Away
    [_passwordconfirm resignFirstResponder];
    
}

//Create Account Button Pressed
- (IBAction)createAccount:(id)sender {
    
    //Start the loading spinner
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.center = _createAccount.center;
    spinner.transform = CGAffineTransformMakeScale(1.8, 1.8);
    spinner.tag = 12;
    [_createAccount.superview insertSubview:spinner aboveSubview:_createAccount];
    [spinner startAnimating];
    [_createAccount setTitle:@"" forState:UIControlStateNormal];
    
    //Used to know if an error was found
    bool errors = false;
    
    NSLog(@"%@", _password.text);
    NSLog(@"%@", _passwordconfirm.text
          );
    
    //Check to make sure all fields are filled out
    if(([_username.text  isEqual: @""]) || ([_password.text  isEqual: @""]) || ([_email.text  isEqual: @""]) || ([_passwordconfirm.text  isEqual: @""]))
    {
        //Stop the loading spinner
        [[self.view viewWithTag:12] stopAnimating];
        [_createAccount setTitle:@"Create Account" forState:UIControlStateNormal];
        
        //Error Occured
        errors = true;
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Sign Up Problem"
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
    
    //Make sure that the two passwords match
    if(_password.text != _passwordconfirm.text)
    {
        //Stop the loading spinner
        [[self.view viewWithTag:12] stopAnimating];
        [_createAccount setTitle:@"Create Account" forState:UIControlStateNormal];
        
        errors = true;
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Sign Up Problem"
                                     message:@"Passwords Do Not Match"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                    }];
        
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    //Create PFUser
    PFUser *user = [PFUser user];
    user.username = _username.text;
    user.password = _password.text;
    user.email = _email.text;
    
    if(errors == false)
    {
        //Start to sign up the user
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            //No Error in signing up
            if (!error)
            {
                //Stop the loading spinner
                [[self.view viewWithTag:12] stopAnimating];
                [_createAccount setTitle:@"Create Account" forState:UIControlStateNormal];
                
                // Hooray! Let them use the app now.
                //Log the User In
                [PFUser logInWithUsernameInBackground:_username.text password:_password.text
                                                block:^(PFUser *user, NSError *error) {
                                                    
                                                    //If User Matches (Should always match)
                                                    if (user)
                                                    {
                                                        // Do stuff after successful login.
                                                        //Go to the main tab view controller
                                                        [self performSegueWithIdentifier:@"tabView" sender:nil];
                                                        
                                                    }
                                                    else
                                                    {
                                                        // The login failed. Check error to see why.
                                                        //Alert with Error
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
            
            //Error in signin up the user
            else
            {
                //Stop the loading spinner
                [[self.view viewWithTag:12] stopAnimating];
                [_createAccount setTitle:@"Create Account" forState:UIControlStateNormal];
                
                //Get what the error is
                NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
                
                //If username already exists
                if([errorString  isEqual: @"Account already exists for this username."])
                {
                    UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:@"Sign Up Problem"
                                                 message:@"Account already exists for this username"
                                                 preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* okButton = [UIAlertAction
                                               actionWithTitle:@"OK"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                               }];
                    
                    [alert addAction:okButton];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                }
                
                //If username was not filled out (it is required)
                if([errorString  isEqual: @"username is required."])
                {
                    UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:@"Sign Up Problem"
                                                 message:@"Username is required"
                                                 preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* okButton = [UIAlertAction
                                               actionWithTitle:@"OK"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                               }];
                    
                    [alert addAction:okButton];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                }
                
                //If Email address format is invalid
                if([errorString  isEqual: @"Email address format is invalid."])
                {
                    UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:@"Sign Up Problem"
                                                 message:@"Email address format is invalid"
                                                 preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* okButton = [UIAlertAction
                                               actionWithTitle:@"OK"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                               }];
                    
                    [alert addAction:okButton];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                }
                
                //If Account already exists for the email address entered
                if([errorString  isEqual: @"Account already exists for this email address."])
                {
                    UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:@"Sign Up Problem"
                                                 message:@"Account already exists for this email address"
                                                 preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* okButton = [UIAlertAction
                                               actionWithTitle:@"OK"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                               }];
                    
                    [alert addAction:okButton];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                }
            
            }
        }];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
