//
//  expenseViewCell.h
//  coin
//
//  Created by Richard Dawson on 12/3/16.
//  Copyright © 2016 Richard Dawson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface expenseViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *expenseName;
@property (strong, nonatomic) IBOutlet UILabel *expenseType;
@property (strong, nonatomic) IBOutlet UIImageView *checkMark;

@property (strong, nonatomic) IBOutlet UILabel *expensePrice;
@property (strong, nonatomic) IBOutlet UILabel *expenseNotes;

@end
