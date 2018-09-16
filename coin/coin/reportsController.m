//
//  reportsController.m
//  coin
//
//  Created by Richard Dawson on 12/4/16.
//  Copyright © 2016 Richard Dawson. All rights reserved.
//

#import "reportsController.h"
#import <Parse/Parse.h>
#import <math.h>

@interface reportsController ()
@property (strong, nonatomic) IBOutlet UILabel *currentMonth;

@end

@implementation reportsController
-(void) loadData {
    //Get the current User LoggedIn
    PFUser *user = [PFUser currentUser];
    
    //Pull all expenses for that user
    PFQuery *query2 = [PFQuery queryWithClassName:@"expense"];
    [query2 whereKey:@"user" equalTo:user.username];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError *error) {
        
        if (!error) {
            completed = 0;
            notCompleted = 0;
            totalBills = 0;
            fixedTotal = @"";
            fixedCalculation = 0.0;
            variableTotal = @"";
            variableCalculation = 0.0;
            expensesCalculation = 0.0;
            averageCalculation   = 0.0;
            mostExpensiveCurrent = 0.0;
            leastExpensiveCurrent = 0.0;
            mostExpensive = @"";
            
            percent1 = 0.0;
            percent2 = 0.0;
            
            //Grab all the expense objects
            expenses = [NSMutableArray arrayWithObjects: @"", nil];
            [expenses removeLastObject];
            for (PFObject *object in objects) {
                [expenses addObject:object];
                
                                 
                if([object[@"expensePrice"] doubleValue] > mostExpensiveCurrent)
                {
                    mostExpensive = object[@"expenseName"];
                    mostExpensiveCurrent = [object[@"expensePrice"] doubleValue];
                }
                
                if([object[@"expensePrice"] doubleValue] < leastExpensiveCurrent)
                {
                    leastExpensive = object[@"expenseName"];
                    leastExpensiveCurrent = [object[@"expensePrice"] doubleValue];
                }
                
                
                if([object[@"completedBool"]  isEqual: @"YES"])
                {
                    completed++;
                }
                
                if([object[@"completedBool"]  isEqual: @"NO"]){
                    notCompleted++;
                }
                
                if([object[@"expenseType"] isEqual: @"Fixed"])
                {
                    fixedTotal = @"";
                    fixedTotal = object[@"expensePrice"];
                    
                    fixedCalculation = fixedCalculation + [fixedTotal doubleValue];
                }
                
                if([object[@"expenseType"] isEqual: @"Variable"])
                {
                    variableTotal = @"";
                    variableTotal = object[@"expensePrice"];
                    
                    variableCalculation = variableCalculation + [variableTotal doubleValue];
                }
                
                
                NSLog(@"%@", object);
                totalBills++;
            }
            if(totalBills != 0)
            {
                percent1 = completed/totalBills;
                percent2 = notCompleted/totalBills;
                
                expensesCalculation = fixedCalculation + variableCalculation;
                averageCalculation = expensesCalculation/totalBills;
                
                _mostExpensive.text = mostExpensive;
                _leastExpensive.text = leastExpensive;
                
                NSString* myNewString6 = [NSString stringWithFormat:@"%.02f", averageCalculation];
                _averageCost.text = myNewString6;
                
                NSString* myNewString5 = [NSString stringWithFormat:@"%.02f", expensesCalculation];
                _totalExpenses.text = myNewString5;
                
                NSString* myNewString3 = [NSString stringWithFormat:@"%.02f", fixedCalculation];
                _totalFixed.text = myNewString3;
                
                NSString* myNewString4 = [NSString stringWithFormat:@"%.02f", variableCalculation];
                _totalVariable.text = myNewString4;
                
                NSString* myNewString = [NSString stringWithFormat:@"%d", completed];
                _billsPaids.text = myNewString;
                
                NSString* myNewString2 = [NSString stringWithFormat:@"%d", notCompleted];
                _billsNotPaid.text = myNewString2;
            }
            
            
        }
        
        else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

//Before view appears
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Load the tableView data
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
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
