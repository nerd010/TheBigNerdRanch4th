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

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.tabBarItem.title = @"Hypnotize";
        UIImage *i = [UIImage imageNamed:@""];
    }
}

- (IBAction)addReminder:(id)sender
{
    NSDateFormatter *datef = [[NSDateFormatter alloc] init];
    [datef setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = self.datePicker.date;
    NSString *dateStr = [datef stringFromDate:date];
    NSLog(@"Setting a reminder for %@", dateStr);
}

@end
