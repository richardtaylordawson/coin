//
//  signOutController.m
//  coin
//
//  Created by Richard Dawson on 11/27/16.
//  Copyright © 2016 Richard Dawson. All rights reserved.
//

#import "signOutController.h"
#import <Parse/Parse.h>
#import <SCLAlertView.h>


@interface signOutController ()

//Outlets to the two email cells
@property (strong, nonatomic) IBOutlet UITableViewCell *feedbackCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *helpCell;

@end

@implementation signOutController

//Function called before Mail Controller loads
- (void)applyComposerInterfaceApperance
{
    //Change nav color to white while emailing
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    //Change nav title to black while emailing
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor blackColor],
                                                          NSForegroundColorAttributeName,
                                                          nil]];
}

//Function called after Mail Controller finishes
- (void)applyGlobalInterfaceAppearance
{
    //Change the nav back to Coin blue
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.41 green:0.61 blue:0.99 alpha:1.0]];
    //Change the title text back to white
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor],
                                                          NSForegroundColorAttributeName,
                                                          nil]];
}

//Function used to detect what cell was clicked
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Get the cell that was clicked based on the index path
    UITableViewCell *theCellClicked = [self.tableView cellForRowAtIndexPath:indexPath];
    
    //Help Cell Touched
    if (theCellClicked == _helpCell) {
        
        //Function to change controller colors
        [self applyComposerInterfaceApperance];
        
        // Email Subject
        NSString *emailTitle = @"Coin iOS App - Help";
        // To address
        NSArray *toRecipents = [NSArray arrayWithObject:@"richard.taylor.dawson@gmail.com"];
        
        //Email Controller
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
    
    //Feedback Cell Tocuhed
    if (theCellClicked == _feedbackCell) {
        
        //Function to change controller colors
        [self applyComposerInterfaceApperance];
        
        // Email Subject
        NSString *emailTitle = @"Coin iOS App - Feedback";
        // To address
        NSArray *toRecipents = [NSArray arrayWithObject:@"richard.taylor.dawson@gmail.com"];
        
        //Email Controller
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
}

//Function called when mail composer is finished
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //Set colors back to normal
    [self applyGlobalInterfaceAppearance];
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//Sign Out button pressed
- (IBAction)signOut:(id)sender {
    
//    SCLAlertView *alert = [[SCLAlertView alloc] init];
//    
//    [alert addButton:@"Yes" actionBlock:^(void) {
//        
//        [PFUser logOut];
//
//        //Start the loading spinner
//        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [spinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
//        spinner.transform = CGAffineTransformMakeScale(1.8, 1.8);
//        spinner.tag = 12;
//        [self.view addSubview:spinner];
//        [spinner startAnimating];
//        
//        [self performSegueWithIdentifier:@"signOut" sender:nil];
//        
//    
//    }];
//   
//    
//    [alert showWarning:self title:@"Alert" subTitle:@"Are you sure you would like to sign out?" closeButtonTitle:@"No" duration:0.0f];
    
    
    
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Alert"
                                 message:@"Are you sure you would like to sign out?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [PFUser logOut];
                                    
                                    //Start the loading spinner
                                    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                                    [spinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
                                    spinner.transform = CGAffineTransformMakeScale(1.8, 1.8);
                                    spinner.tag = 12;
                                    [self.view addSubview:spinner];
                                    [spinner startAnimating];
                                    
                                    [self performSegueWithIdentifier:@"signOut" sender:nil];
                                    
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

- (void)viewDidLoad {
}

- (void)didReceiveMemoryWarning {
}

@end
