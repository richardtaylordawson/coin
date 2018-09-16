//
//  forgotPasswordController.m
//  coin
//
//  Created by Richard Dawson on 11/28/16.
//  Copyright © 2016 Richard Dawson. All rights reserved.
//

#import "forgotPasswordController.h"
#import <Parse/Parse.h>

@interface forgotPasswordController ()

@end

@implementation forgotPasswordController

//Done button pressed on email
- (IBAction)emailDoneButton:(id)sender {
    
    //Put keyboard away
    [_emailAddress resignFirstResponder];
}

//Reset button pressed
- (IBAction)resetPassword:(id)sender
{
    //Can't use this anymore
    //[PFUser requestPasswordResetForEmailInBackground:_emailAddress.text];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
