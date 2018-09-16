//
//  resetPassword.m
//  coin
//
//  Created by Richard Dawson on 12/5/16.
//  Copyright © 2016 Richard Dawson. All rights reserved.
//

#import "resetPassword.h"
#import <Parse/Parse.h>
#import <RFKeyboardToolbar.h>

@interface resetPassword ()
@property (strong, nonatomic) IBOutlet UIButton *changePasswordBtn;

@end

@implementation resetPassword

//Next button touched on password
- (IBAction)nextBtnTouched:(id)sender {
    [_confirmPassword becomeFirstResponder];
}

//Done button touched on confirm password
- (IBAction)doneBtnTouched:(id)sender {
    [_confirmPassword resignFirstResponder];
}

- (IBAction)resetPassword:(id)sender {
    
    //Used to keep track of errors
    bool errors = false;
    
    //Start the loading spinner
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.center = _changePasswordBtn.center;
    spinner.transform = CGAffineTransformMakeScale(1.8, 1.8);
    spinner.tag = 12;
    [_changePasswordBtn.superview insertSubview:spinner aboveSubview:_changePasswordBtn];
    [spinner startAnimating];
    [_changePasswordBtn setTitle:@"" forState:UIControlStateNormal];
    
    [_password resignFirstResponder];
    [_confirmPassword resignFirstResponder];
    
    //Check to make sure all the fields are filled out
    if(([_password.text  isEqual: @""]) || ([_confirmPassword.text  isEqual: @""]))
    {
        errors = true;
        //Stop the loading spinner
        [[self.view viewWithTag:12] stopAnimating];
        
        //Clear out the password fields
        _password.text = nil;
        _confirmPassword.text = nil;
        
        [_changePasswordBtn setTitle:@"Change Password" forState:UIControlStateNormal];
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Form Problem"
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
    
    if(_password.text != _confirmPassword.text)
    {
        errors = true;
        //Stop the loading spinner
        [[self.view viewWithTag:12] stopAnimating];
        
        //Clear out the password fields
        _password.text = nil;
        _confirmPassword.text = nil;
        
        [_changePasswordBtn setTitle:@"Change Password" forState:UIControlStateNormal];
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Form Problem"
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

    if(!errors)
    {
        //Get the current User LoggedIn
        PFUser *user = [PFUser currentUser];
        //Stop the loading spinner
        
        user.password = _password.text;
        
        //Clear out the password fields
        _password.text = nil;
        _confirmPassword.text = nil;
        
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            
            if (!error) {
                
                [[self.view viewWithTag:12] stopAnimating];
                [_changePasswordBtn setTitle:@"Change Password" forState:UIControlStateNormal];
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"Success!"
                                             message:@"Password Changed"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* okButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                                           }];
                
                [alert addAction:okButton];
                
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            
            else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set the title of the page
    self.title = @"Change Password";
    
//    //Password Done Button
//    RFToolbarButton *passwordDone = [RFToolbarButton buttonWithTitle:@"Done"];
//    [passwordDone addEventHandler:^{
//        [_password resignFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    passwordDone.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [passwordDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Password Next Button
//    RFToolbarButton *passwordNext = [RFToolbarButton buttonWithTitle:@"Next"];
//    [passwordNext addEventHandler:^{
//        [_confirmPassword becomeFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    passwordNext.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [passwordNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Add Password Buttons
//    _password.inputAccessoryView = [RFKeyboardToolbar toolbarWithButtons:@[passwordDone, passwordNext]];
//    [self.view addSubview:_password];
//    
//    //Password Confirm Done Button
//    RFToolbarButton *passwordConfirmDone = [RFToolbarButton buttonWithTitle:@"Done"];
//    [passwordConfirmDone addEventHandler:^{
//        [_confirmPassword resignFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    passwordConfirmDone.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [passwordConfirmDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Password Confirm Previous Button
//    RFToolbarButton *passwordConfirmPrevious = [RFToolbarButton buttonWithTitle:@"Previous"];
//    [passwordConfirmPrevious addEventHandler:^{
//        [_password becomeFirstResponder];
//    } forControlEvents:UIControlEventTouchUpInside];
//    passwordConfirmPrevious.backgroundColor = [UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0];
//    [passwordConfirmPrevious setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    //Add Password Buttons
//    _confirmPassword.inputAccessoryView = [RFKeyboardToolbar toolbarWithButtons:@[passwordConfirmDone, passwordConfirmPrevious]];
//    [self.view addSubview:_confirmPassword];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
