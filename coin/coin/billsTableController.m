//
//  billsTableController.m
//  coin
//
//  Created by Richard Dawson on 1/14/17.
//  Copyright © 2017 Richard Dawson. All rights reserved.
//

//
//  homeViewController.m
//  coin
//
//  Created by Richard Dawson on 11/30/16.
//  Copyright © 2016 Richard Dawson. All rights reserved.
//

#import "billsTableController.h"
#import <Parse/Parse.h>

@interface billsTableController ()

@end

@implementation billsTableController



//Loads the TableView Data when called
-(void) loadData {
    
    //Get the current User LoggedIn
    PFUser *user = [PFUser currentUser];
    
    //Pull all expenses for that user
    PFQuery *query2 = [PFQuery queryWithClassName:@"expense"];
    [query2 whereKey:@"user" equalTo:user.username];
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
            [self.expensesTable reloadData];
            
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
                                                
                                                     //toggle the correct view to be visible
                                                     [self loadData];
                                                     
                                                 
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
        
            NSIndexPath* ip = (NSIndexPath*)sender;
            dvc.positionInArray = ip;
        }
    }
}

//Before view appears
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];
    
    self.title = @"Home";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.expensesTable.delegate = self;
    self.expensesTable.dataSource = self;
    
    [self.expensesTable registerNib:[UINib nibWithNibName:@"expenseViewCell" bundle:nil] forCellReuseIdentifier:@"expenseCellCustom"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
