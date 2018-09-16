//
//  addExpense.h
//  coin
//
//  Created by Richard Dawson on 11/30/16.
//  Copyright © 2016 Richard Dawson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addExpense : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

//Used to store the picker data
{
    NSArray *_pickerData;
}

@end
