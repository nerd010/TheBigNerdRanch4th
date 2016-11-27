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

- (IBAction)addReminder:(id)sender
{
    NSDateFormatter *datef = [[NSDateFormatter alloc] init];
    [datef setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = self.datePicker.date;
    NSString *dateStr = [datef stringFromDate:date];
    NSLog(@"Setting a reminder for %@", dateStr);
}

@end
