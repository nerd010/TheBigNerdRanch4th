//
//  BNRReminderViewController.m
//  BNRHypnoNerd
//
//  Created by Richard Wang on 2016/11/26.
//  Copyright © 2016年 Richard Wang. All rights reserved.
//

#import "BNRReminderViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface BNRReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.tabBarItem.title = @"Reminder";
        self.tabBarItem.image = [UIImage imageNamed:@"Time.png"];
    }
    return  self;
}


- (IBAction)addReminder:(id)sender
{
    NSDateFormatter *datef = [[NSDateFormatter alloc] init];
    [datef setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = self.datePicker.date;
    NSString *dateStr = [datef stringFromDate:date];
    NSLog(@"Setting a reminder for %@", dateStr);
    
//    UILocalNotification *note = [[UILocalNotification alloc] init];
//    note.alertBody = @"Hypnotize me!";
//    note.fireDate = date;
//    [[UIApplication sharedApplication] scheduleLocalNotification:note];
    
    [self registerNotification:30];
}

- (void)registerNotification:(NSInteger )alerTime
{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"Hello!" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:@"Hypnotize me!" arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:alerTime repeats:NO];
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"
                                                                          content:content trigger:trigger];
    //添加推送成功后的处理！
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }];
}
@end
