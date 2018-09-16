//
//  detailViewController.h
//  coin
//
//  Created by Richard Dawson on 12/1/16.
//  Copyright © 2016 Richard Dawson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailViewController : UIViewController
{
    NSMutableArray * expenses;
    NSString * key;
}
@property (strong, nonatomic) IBOutlet UITextField *expenseName;
@property (strong, nonatomic) IBOutlet UITextField *expenseType;
@property (strong, nonatomic) IBOutlet UITextField *expensePrice;
@property (strong, nonatomic) IBOutlet UITextView *expenseNotes;
@property (strong, nonatomic) IBOutlet UISwitch *expenseSwitch;

@property (strong, nonatomic) NSIndexPath* positionInArray;
@property (strong, nonatomic) NSString* segment;

@end

