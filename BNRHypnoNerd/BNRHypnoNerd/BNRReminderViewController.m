//
//  BNRReminderViewController.m
//  BNRHypnoNerd
//
//  Created by Richard Wang on 2016/11/26.
//  Copyright © 2016年 Richard Wang. All rights reserved.
//

#import "BNRReminderViewController.h"

@interface BNRReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

- (void)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
}

@end
