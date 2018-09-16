//
//  homeViewController.m
//  coin
//
//  Created by Richard Dawson on 11/30/16.
//  Copyright © 2016 Richard Dawson. All rights reserved.
//

#import "homeViewController.h"
#import <Parse/Parse.h>

@interface homeViewController ()
@property (strong, nonatomic) IBOutlet UILabel *currentMonth;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation homeViewController

//When view is changed
- (IBAction)segmentedControllTouched:(id)sender {
    NSInteger selectedSegment = _segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        //toggle the correct view to be visible
        [self loadData];
    }
    else{
        //toggle the correct view to be visible
        [self loadData2];
    }
}

-(void) loadData2 {
    
    //Get the current User LoggedIn
    PFUser *user = [PFUser currentUser];
    
    //Pull all expenses for that user
    PFQuery *query2 = [PFQuery queryWithClassName:@"expense"];
    [query2 whereKey:@"user" equalTo:user.username];
    [query2 whereKey:@"expenseType" equalTo:@"Variable"];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError *error) {
        
        if (!error) {
            
            //Grab all the expense objects
            expenses = [NSMutableArray arrayWithObjects: @"", nil];
            [expenses removeLastObject];
            for (PFObject *object in objects) {
                [expenses addObject:object];
                //NSLog(@"%@", object);
                
            }
            
            //Reload the TableView
            [self.expenseTableView reloadData];
            
        }
        
        else {
            // Log details of the failure
            NSLog(@"Some stuff: %@ %@", error, [error userInfo]);
        }
    }];
}

//Loads the TableView Data when called
-(void) loadData {
    
    //Get the current User LoggedIn
    PFUser *user = [PFUser currentUser];
    
    //Pull all expenses for that user
    PFQuery *query2 = [PFQuery queryWithClassName:@"expense"];
    [query2 whereKey:@"user" equalTo:user.username];
    [query2 whereKey:@"expenseType" equalTo:@"Fixed"];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError *error) {
        
        if (!error) {
            
            //Grab all the expense objects
            expenses = [NSMutableArray arrayWithObjects: @"", nil];
            [expenses removeLastObject];
            for (PFObject *object in objects) {
                [expenses addObject:object];
                //NSLog(@"%@", object);
                
            }
            
            
            //Reload the TableView
            [self.expenseTableView reloadData];
            
        }
        
        else {
            // Log details of the failure
            NSLog(@"Some stuff: %@ %@", error, [error userInfo]);
        }
    }];
}

//Method so you can edit cells
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//Called when editting cells
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //If cell is deleted
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //Get the query
        PFQuery *query = [PFQuery queryWithClassName:@"expense"];
        
        //Get the key
        key = [expenses[indexPath.row] objectId];
        
        //Remove the object the array
        [expenses removeObjectAtIndex:indexPath.row];
        
        //Animate the delete
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        // Retrieve the object by id
        [query getObjectInBackgroundWithId:key
                                     block:^(PFObject *expense, NSError *error) {
                                         
                                         [expense deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                             if (succeeded) {
                                                //Reload the table
                                                NSInteger selectedSegment = _segmentedControl.selectedSegmentIndex;
                                                 
                                                 if (selectedSegment == 0) {
                                                     //toggle the correct view to be visible
                                                     [self loadData];
                                                 }
                                                 else{
                                                     //toggle the correct view to be visible
                                                     [self loadData2];
                                                 }
                                                 
                                                 
                                             } else {
                                                 // There was a problem, check error.description
                                             }
                                         }];
                                         
                                     }];
       
    }
}

//TableView number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//TableView number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return expenses.count;
}

//TableView Cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat result;
    result = 70.0f;
    return result;
}

//Create each reusable cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Use the custom table view cell
    expenseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"expenseCellCustom" forIndexPath:indexPath];
    
    //Create a dictionary based on what expense we are on
    NSDictionary* d = expenses[indexPath.row];
    cell.expenseName.text = d[@"expenseName"];
    cell.expenseNotes.text = d[@"expenseNotes"];
    cell.expensePrice.text = [@"$" stringByAppendingString:d[@"expensePrice"]];
    cell.expenseType.text = d[@"expenseType"];

    //Change the cell color if paid
    if([d[@"completedBool"] isEqualToString:@"YES"]){
        cell.checkMark.image = [UIImage imageNamed:@"checkmark.png"];
    }
    else if([d[@"completedBool"] isEqualToString:@"NO"])
    {
        cell.checkMark.image = [UIImage imageNamed:@""];
    }
    
    //Return
    return cell;
}

//Perform Segue when the cell is touched
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"cellTouched" sender:indexPath];
}

//Before the segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //If cell was touched seque
    if ([segue.identifier isEqualToString:@"cellTouched"]) {
        
        detailViewController* dvc = (detailViewController*)segue.destinationViewController;
        
        if(sender) {
            if(_segmentedControl.selectedSegmentIndex == 0)
            {
                dvc.segment = @"Fixed";
            }
            else{
                dvc.segment = @"Variable";
            }
            NSIndexPath* ip = (NSIndexPath*)sender;
            dvc.positionInArray = ip;
        }
    }
}

//Before view appears
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Get the selected segment
    NSInteger selectedSegment = _segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        //toggle the correct view to be visible
        [self loadData];
    }
    else{
        //toggle the correct view to be visible
        [self loadData2];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.expenseTableView.delegate = self;
    self.expenseTableView.dataSource = self;
    
    [self.expenseTableView registerNib:[UINib nibWithNibName:@"expenseViewCell" bundle:nil] forCellReuseIdentifier:@"expenseCellCustom"];
     
    //Get the date
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"M"];
    NSString *dateString = [dateFormat stringFromDate:today];
    
    //Set the date string
    if([dateString  isEqual: @"1"])
    {
        dateString = @"January";
    }
    else if ([dateString  isEqual: @"2"])
    {
        dateString = @"February";
    }
    else if ([dateString  isEqual: @"3"])
    {
        dateString = @"March";
    }
    else if ([dateString  isEqual: @"4"])
    {
        dateString = @"April";
    }
    else if ([dateString  isEqual: @"5"])
    {
        dateString = @"May";
    }
    else if ([dateString  isEqual: @"6"])
    {
        dateString = @"June";
    }
    else if ([dateString  isEqual: @"7"])
    {
        dateString = @"July";
    }
    else if ([dateString  isEqual: @"8"])
    {
        dateString = @"August";
    }
    else if ([dateString  isEqual: @"9"])
    {
        dateString = @"September";
    }
    else if ([dateString  isEqual: @"10"])
    {
        dateString = @"October";
    }
    else if ([dateString  isEqual: @"11"])
    {
        dateString = @"November";
    }
    else if ([dateString  isEqual: @"12"])
    {
        dateString = @"December";
    }
    
    //Set the label to the current date
    _currentMonth.text = dateString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
