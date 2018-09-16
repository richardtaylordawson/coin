//
//  homeViewController.h
//  coin
//
//  Created by Richard Dawson on 11/30/16.
//  Copyright © 2016 Richard Dawson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailViewController.h"
#import "expenseViewCell.h"

@interface homeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

//Used to store the expenses locally
{
    NSMutableArray* expenses;
    NSMutableArray* expenses2;
    NSString * key;
}

//TableView Outlet
@property (strong, nonatomic) IBOutlet UITableView *expenseTableView;

@end
