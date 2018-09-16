//
//  reportsController.h
//  coin
//
//  Created by Richard Dawson on 12/4/16.
//  Copyright © 2016 Richard Dawson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface reportsController : UIViewController
{
    NSMutableArray * expenses;
    int completed;
    int notCompleted;
    int totalBills;
    
    NSString *fixedTotal;
    double fixedCalculation;
    
    NSString *variableTotal;
    double variableCalculation;
    
    NSString *expensesTotal;
    double expensesCalculation;
    
    NSString *mostExpensive;
    NSString *leastExpensive;
    double mostExpensiveCurrent;
    double leastExpensiveCurrent;
    
    double averageCalculation;
    
    double percent1;
    double percent2;
}
@property (strong, nonatomic) IBOutlet UITextField *totalExpenses;
@property (strong, nonatomic) IBOutlet UITextField *totalVariable;
@property (strong, nonatomic) IBOutlet UITextField *totalFixed;

@property (strong, nonatomic) IBOutlet UITextField *billsPaids;
@property (strong, nonatomic) IBOutlet UITextField *billsNotPaid;

@property (strong, nonatomic) IBOutlet UITextField *averageCost;

@property (strong, nonatomic) IBOutlet UITextField *leastExpensive;
@property (strong, nonatomic) IBOutlet UITextField *mostExpensive;
@end
