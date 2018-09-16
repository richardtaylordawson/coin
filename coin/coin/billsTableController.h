//
//  billsTableController.h
//  coin
//
//  Created by Richard Dawson on 1/14/17.
//  Copyright © 2017 Richard Dawson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailViewController.h"
#import "expenseViewCell.h"

@interface billsTableController : UIViewController <UITableViewDelegate, UITableViewDataSource>

//Used to store the expenses locally
{
    NSMutableArray* expenses;
    NSString * key;
}

//TableView Outlet
@property (strong, nonatomic) IBOutlet UITableView *expensesTable;


@end
