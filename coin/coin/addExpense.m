//
//  addExpense.m
//  coin
//
//  Created by Richard Dawson on 11/30/16.
//  Copyright © 2016 Richard Dawson. All rights reserved.
//

#import "addExpense.h"
#import <Parse/Parse.h>

@interface addExpense ()

//Outlets for the Expense Object
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UITextField *expenseName;
@property (strong, nonatomic) IBOutlet UITextField *price;
@property (strong, nonatomic) IBOutlet UITextView *notes;

@end

@implementation addExpense

//Save Button Touched
- (IBAction)save:(id)sender {
    
    //Used to see if there are any errors
    bool errors = false;
    
    //Check to make sure all fields are filled out
    if(([_expenseName.text  isEqual: @""]) || ([_price.text  isEqual: @""]))
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
    NSScanner *scanner = [NSScanner scannerWithString:_price.text];
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
        //Get the current User
        PFUser *user = [PFUser currentUser];
        
        //Create the expense object
        PFObject *expense = [PFObject objectWithClassName:@"expense"];
        
        //Set expense object values
        expense[@"expenseName"] = _expenseName.text;
        NSString *pickerValue = [self pickerView:self.pickerView
                                      titleForRow:[_pickerView selectedRowInComponent:0]
                                     forComponent:0
                                  ];
        expense[@"expenseType"] = pickerValue;
        expense[@"expensePrice"] = _price.text;
        expense[@"expenseNotes"] = _notes.text;
        expense[@"completedBool"] = @"NO";
        expense[@"user"] = user.username;
        
        //Save the expense object
        [expense saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // The object has been saved.
                //Perform Segue
                [self performSegueWithIdentifier:@"saveOrCancel" sender:nil];
            } else {
                // There was a problem, check error.description
            }
        }];   
    }
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set the title of the page
    self.title = @"Add Expense";
    
    //Set the picker data
    _pickerData = @[@"Fixed", @"Variable"];
   
    //Set the pickerview delegate and datasource
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
